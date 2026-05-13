Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106991D63F3
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 02:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778641124; cv=none; b=qf7oYgxKCOztUQaFwHofZeH1ej4GDGuBQlxzaX+1alSZ11AP490xIiYxnL3vbfTHS5ArAc6TAUDksp8BEwV1ag9z7HiP54loB+xKvYAsQSrBYjOoLgD9NbNLgCqE1WDcAiSG3AePjK1nrfSFpfiGiwHtsFwlFLHNi2bxpnglFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778641124; c=relaxed/simple;
	bh=gyXsiRCsCOCBKYUHUNkxpLOctkk4sQi86LA6Gfq+qo0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EVgcwVKPJe5oTEM8YeVjWKdzG3yWxzbrQje7rDfRBzZ9G0y7XE1/0dI829ydNpk7OjcOEmi/HPXc5MTutijGznv/eF6U/7skdjvIvPw+j7MaWMZW2/0Mqqhe3rWG4RyUDhNb1il6FmlcAPR2WwYTneK2kxagC0Ni4DrQ0ocTziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuE/XHmJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuE/XHmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939F7C2BCB0;
	Wed, 13 May 2026 02:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778641123;
	bh=gyXsiRCsCOCBKYUHUNkxpLOctkk4sQi86LA6Gfq+qo0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HuE/XHmJ96PAa3u8YPpADmPWqH41nKoDCOfoK3ho8F4OOhO4cf2qkzuxD6BVVkANZ
	 /u9quuWNE0+CRdWGIBMAbsp4x/QTb7as9UE6Ff8ITDkzfK4comDe03VI6INwUMfUg5
	 jqnlSMxhOQxTyP9UUopuSqkvvYTSuCcbn403DZGSFrwHSwSd5C3zLW57gvRZtMcYgM
	 /2PApXUo2pWl/itG5UB2+Sh45BmoHm3AVlbsF2YvXPa7GNiaaVXaEV5D7pXWnHqZnA
	 OUtgkaz5vBPkK7r7Lmlo5OWurHO3Ys9P2GfexMi75cYaqMnHYzQaG6BsVNTm326Hxo
	 6t1ieF8v0+tZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] perf/x86/intel/uncore: Move die_to_cpu() to
 uncore.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260511230527.26096-5-zide.chen@intel.com>
References: <20260511230527.26096-5-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 02:58:43 +0000
Message-Id: <20260513025843.939F7C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Recursive `cpus_read_lock()` acquisition leads to deadlock when us=
ed by the planned initialization callback.
--

commit d8b9d983f61a73e17f268ae570b5186a67f1a6ae
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Move die_to_cpu() to uncore.c

This commit moves die_to_cpu() into uncore.c and renames it to
uncore_die_to_cpu(). This change prepares the function to be reused by a
planned MSR global initialization callback.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index e9cc1ba921c5e..2bbe4cc1df3e2 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
[ ... ]
> @@ -83,6 +83,25 @@ int uncore_device_to_die(struct pci_dev *dev)
>  	return -1;
>  }
> =20
> +int uncore_die_to_cpu(int die)
> +{
> +	int res =3D 0, cpu;
> +
> +	/*
> +	 * Using cpus_read_lock() to ensure cpu is not going down between
> +	 * looking at cpu_online_mask.
> +	 */
> +	cpus_read_lock();

Will the planned MSR global initialization callback already hold
cpus_read_lock() when it calls this function?

If the initialization path (such as uncore_discovery_msr() calling into
__parse_discovery_table()) already holds the lock, does acquiring it a
second time here risk a lockdep warning or a deadlock?

Since cpus_read_lock() is backed by a percpu rwsem, a second read lock by
the same thread can block if a writer (like CPU hotplug) is pending. Does
this API need an unlocked variant for initialization paths, or should it
rely on the caller to manage the lock entirely?

> +	for_each_online_cpu(cpu) {
> +		if (topology_logical_die_id(cpu) =3D=3D die) {
> +			res =3D cpu;
> +			break;
> +		}
> +	}
> +	cpus_read_unlock();
> +	return res;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511230527.2609=
6-1-zide.chen@intel.com?part=3D4
