Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3A3911DF;
	Mon, 24 Aug 2026 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607367; cv=none; b=bnxQcE1nUkx2h7lYYg7yO8c3B07UgmjOgjBRMPUvQr8TMJO9BGj+NTI4lz5+6nxEDiMLOS4h1KKmFG9FUCtNhJKvRMre22GKL/o+4GYJvB+0ATlXtW3EKQphBAkOKYfRsI8lTFsK6qQDytd8I3tVnKrILAY+wxldTiU79rAEH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607367; c=relaxed/simple;
	bh=oSvptDeaBKqtPwkifKYsoQf3OVBGWOkr1B0K9Bb/Qes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRWy0+A3DLyi4ZtS06LmTWTPszNlRibjwYMrfCbPimV60Op7lhf+RlzvuheouzROTziO3YdoWgCuNTgxzRDuvGzTg1GAA7KM4HBD4Irtx6ovs4bqi58vfhBorep9Mdp9NTQBRa3Dwt2LwKgk1e0SUd/dJMPiCBXkcUEIrJy6Wo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX18EG1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX18EG1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A058A1F000E9;
	Mon, 24 Aug 2026 21:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787607365;
	bh=yWh0D3bCzwg7GLmN3zIV3DPKuGu1Z14SAqtMVigfdLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dX18EG1KPejM1yCAUzzY3apsbnZK16y5j9Kxg/A1HP6eHSz5pzKYcwH0b0LVpFxZk
	 yRyMT8FRKj5pqtU0itjns2o2Oi1GT8f3DsKJCuNsfGW1u1BBMzbr/grI/yLMtpiZow
	 uraG+js8MLaUJLhFB0Iik1gtyUCK44TZEkp2D2cKVZ8uA36ZkT1xTF0VUcc0KV1VQC
	 1npQhgPjNSRAhXnGRowEsnQsfG+x3aBV5k5VDGqR2qPjCT+2fAg2b0Jm4bwNdbNVfu
	 JxQ4ftermgf9BA+AhR58Wzp/HMk9DfVuPy828NDzHUxjlMFKob9SmJQFwLrKK4klXc
	 PjVaO4X1eL1Fw==
Date: Mon, 24 Aug 2026 14:36:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 05/23] perf dwarf-regs: Adapt get_dwarf_regnum() for
 arm64
Message-ID: <aoy5RKhAOw8t3j5h@google.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-6-wutengda@huaweicloud.com>
 <20260808131253.107781F000E9@smtp.kernel.org>
 <d6324221-0fc6-40e9-9003-52c7d509daeb@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6324221-0fc6-40e9-9003-52c7d509daeb@huaweicloud.com>

On Tue, Aug 11, 2026 at 03:18:42PM +0800, Tengda Wu wrote:
> 
> 
> On 2026/8/8 21:12, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] The programmatic DWARF register lookup __get_dwarf_regnum_arm64() fails to support the standard AArch64 'lr' (link register) and 'fp' (frame pointer) aliases.
> > --
> > 
> > --- Patch [5]: [PATCH v4 05/23] perf dwarf-regs: Adapt get_dwarf_regnum() for arm64 ---
> > commit 7e82be98e18ee79f31ad73b727e21d33b0a6f30d
> > Author: Tengda Wu <wutengda@huaweicloud.com>
> > 
> > perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
> > 
> > This patch replaces the static string table lookup for arm64 DWARF registers
> > with a programmatic implementation. This change allows resolving arm64
> > register names directly into their corresponding DWARF register numbers
> > during annotation parsing.
> > 
> >> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> >> index 593ca7d4fccca..720c863d18696 100644
> >> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> >> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> > 
> > [ ... ]
> > 
> >> @@ -10,3 +13,22 @@ int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum)
> >>  
> >>  	return perf_regnum;
> >>  }
> >> +
> >> +int __get_dwarf_regnum_arm64(const char *name)
> >> +{
> >> +	int reg;
> >> +
> >> +	if (!strcmp(name, "sp"))
> >> +		return 31;
> >> +
> >> +	if (*name != 'x' && *name != 'w')
> >> +		return -ENOENT;
> > 
> > [Severity: Medium]
> > Will this strict prefix check inadvertently reject standard AArch64 aliases
> > like lr and fp?
> > 
> > These architectural aliases are frequently emitted by objdump and were
> > previously handled by the old static table. When perf annotate attempts
> > to look up lr or fp, this programmatic DWARF register lookup in
> > __get_dwarf_regnum_arm64() will fail because the name does not start with
> > x or w.
> > 
> 
> Currently, I have not seen such aliases in AArch64 disassembly output,
> nor are they documented in the manual. Therefore, I will not change this
> and will keep it as-is.
 
Right, I don't expect them to be used for typed reference.

Thanks,
Namhyung

