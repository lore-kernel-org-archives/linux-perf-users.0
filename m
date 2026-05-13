Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67432384CF3
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705749; cv=none; b=qTmGLN8923jNptKpPE/iEpNKJhJPL935I75M1h040ZHTQmuY8MrREiJlMu0+pl0IAehmw3fRsPEGtQapo6dadxCfDJhgjQWmSs7OTu7Ggc9l4kvU3MQHkXhGOxf5s48vTQJj8PrG2CXe9Wt+kEPQInjnuLCzJxBLYg9hY/z8fcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705749; c=relaxed/simple;
	bh=X4uRMkf6rfOAxSfao/wYgHxDMx3h+mqePuQk2J1l29g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aqLsFeP6kUNXA67Y7uM1JoZ8PvxGC7Q3SGbcHBpEirye0c6jT8wJK5PzaGK5dgV/k82OUdZxXl75m13wj72WYkflr5hzdJEd2PHyulp2YwW8YajS00LKder6UjecgJt/gCcwPSGKSMH49tcBpTG1iQNGUUZ+9ZkiK4jf3LU0eUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe7T/FvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe7T/FvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED260C19425;
	Wed, 13 May 2026 20:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778705749;
	bh=X4uRMkf6rfOAxSfao/wYgHxDMx3h+mqePuQk2J1l29g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oe7T/FvYLlpHQKJjv/vYLsUS+ykYYEY/WKL4h9DsIfpnkneMkj6vcDvZg8Ghi++Uu
	 Nn57m3ln7HwTIor3x1/i5Gh2OKKylLsYbn69nh/oEmma3V5vkdEHYBE6u18VUxWJIi
	 /1Rzsbrl2T114LBfWRAVMlAHe8VYfpgfWWKceP38i71eHRVWhi5e4pmwPIQl627Yr/
	 Xd4Mc7T5tP0TwgSysek/VJTJS+p7vysXDJcNZcPOiVQ1xyIfNqMQHyC/c4yvN+VXY/
	 j9gMYQr+PNNou2tUCZuERzS3aqmbJz8Lm3tho4txTYh4YyGa0ntQkyqMcPh+P800u1
	 +HKZF+lqDVT8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf kvm stat: Update the exit reason mappings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Menghani" <gautam@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512120408.59332-1-gautam@linux.ibm.com>
References: <20260512120408.59332-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:55:48 +0000
Message-Id: <20260513205548.ED260C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch adds `H_FAC_UNAVAIL` to the exit reason mappings, but =
this mapping is missing from `trace_book3s.h`, contradicting the commit mes=
sage.
--

commit ece070bf3559f07c600d918f34f26871f45c741d
Author: Gautam Menghani <gautam@linux.ibm.com>

perf kvm stat: Update the exit reason mappings

This commit updates the exit reason mappings in perf to sync them with
the definitions in trace_book3s.h.

> diff --git a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h b/tools/perf=
/util/kvm-stat-arch/book3s_hv_exits.h
> index 2011376c7ab58..2688ca7d03990 100644
> --- a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
> +++ b/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
> @@ -26,8 +26,10 @@
>  	{0xe00, "H_DATA_STORAGE"}, \
>  	{0xe20, "H_INST_STORAGE"}, \
>  	{0xe40, "H_EMUL_ASSIST"}, \
> +	{0xea0, "H_VIRT"}, \
>  	{0xf00, "PERFMON"}, \
>  	{0xf20, "ALTIVEC"}, \
> -	{0xf40, "VSX"}
> +	{0xf40, "VSX"}, \
> +	{0xf80, "H_FAC_UNAVAIL"}

The commit message states "Sync the exit reason mappings with the mappings
in trace_book3s.h".

Is this description accurate? Looking at arch/powerpc/kvm/trace_book3s.h,
it does not contain the mapping for H_FAC_UNAVAIL (0xf80):

arch/powerpc/kvm/trace_book3s.h:
#define kvm_trace_symbol_exit \
...
	{0xea0, "H_VIRT"}, \
	{0xf00, "PERFMON"}, \
	{0xf20, "ALTIVEC"}, \
	{0xf40, "VSX"}

Because trace_book3s.h lacks H_FAC_UNAVAIL, the ftrace kvm_guest_exit
tracepoint and perf kvm stat remain out of sync, as ftrace will display
the raw vector while perf will decode it.

Should trace_book3s.h also be updated to ensure they are truly synchronized?

Additionally, several other common KVM exits defined in kvm_asm.h, such as
HMI (0xe60) and H_DOORBELL (0xe80), appear to be missing from both headers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512120408.5933=
2-1-gautam@linux.ibm.com?part=3D1
