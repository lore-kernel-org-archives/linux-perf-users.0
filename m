Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51911CA9;
	Mon,  3 Mar 2025 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041293; cv=none; b=BjuWzi+GbD3w+ziRqn2qZILWyNNvq5d7O3F06z061T+Tk9IM8dUkwPqoYRnSzCjLWFEsElT/G+CQ0k8HJ60gl0M1y8REr+SgtOoXo1ckGsaw87kIpYW5n4jz5CdWl8eNxTiXMK04f/bFUs00zqTPhL+z5fsgXiAJzmdyAdOt6Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041293; c=relaxed/simple;
	bh=F30QHXKrlOqCuPBKSY4pSSMBNSfxTebs969Cd+lS1F0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UpcE0xnYC7XQh7TttVFT7bshLgIOuhKjRHe5jg3hnSimkWlvpLzL13f2gB6vxZSZ3f0MH9LBkdVKcRD4p1WmScoTV+6zZs1m9vZr952h+gUDaOxqUEHKI8FPWMquF0leG9NpL3siQ9MCurWlEvt0RxppO2mCIePTXksf3toHdkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=LdTRf7fr; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LdTRf7fr"
Received: from [IPv6:::1] ([172.59.161.144])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 523MYBht1781244
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Mar 2025 14:34:13 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 523MYBht1781244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741041254;
	bh=yQK8hVfe3l9Z3etcB2YNPrMft+SViGKW39OaDCOwqHk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=LdTRf7fr5G4o2XMAm778Q9TDcI6UDgmRTS+1xsfKDq0AhhVcfrmxIoETJZ+nPi8Ow
	 edcZkGzlKutQJ5cFT2ml5SyYb5Fq2kVyAOFEklcGwPMTjM/FMQy9CAmENYlWQiN9lg
	 /cp3c1IeXGhDCziFrWBT2XkQcD2zky0Q+Vebz7YytR0WOPvJIXSqa8ZnKcWuz1LTpD
	 PhX0gcxQ8dt0M3Wm619z42LKad4skAy/WGuUohHsQ2N+T2xDmFQp7EuBwpBWVOvRof
	 7G61JI0nQmiSEtugXCPHh6lagMiOA87W5D5f85uDSprD0cIrjvqjxhl6wnbK7CaipQ
	 Kfa0GN0s0epIw==
Date: Mon, 03 Mar 2025 14:34:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Aithal, Srikanth" <sraithal@amd.com>, "Xin Li (Intel)" <xin@zytor.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, will@kernel.org, peterz@infradead.org,
        yury.norov@gmail.com, akpm@linux-foundation.org, acme@kernel.org,
        namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com,
        nik.borisov@suse.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_3/5=5D_x86/cpufeatures=3A_Generate?=
 =?US-ASCII?Q?_a_feature_mask_header_based_on_build_config?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250303132505.GEZ8WtsXqFpuMOpDjT@fat_crate.local>
References: <20250228082338.73859-1-xin@zytor.com> <20250228082338.73859-4-xin@zytor.com> <7c3b4623-45ea-4340-ac47-334071c1d15f@amd.com> <D03DAFD2-5EC9-4D16-BA66-FDA4B51F45DD@zytor.com> <20250303132505.GEZ8WtsXqFpuMOpDjT@fat_crate.local>
Message-ID: <BCD39CA4-97F7-4B33-88BF-98BF17775DCA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 3, 2025 5:25:05 AM PST, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Mon, Mar 03, 2025 at 04:05:54AM -0800, H=2E Peter Anvin wrote:
>> "make headers" on an unconfigured tree should presumably only produce t=
he uapi headers, not kernel-internal ones, one could surmise?
>
>Well, that's kinda a question for you guys:
>
>cfc7686900a87   (H=2E Peter Anvin (Intel) 2025-02-28 00:23:36 -0800      =
 281)archheaders: $(out)/$(featuremasks_hdr)
>1f57d5d85ba7f   (Ingo Molnar    2015-06-03 18:36:41 +0200       282)    $=
(Q)$(MAKE) $(build)=3Darch/x86/entry/syscalls all
>
>and the headers target has
>
>headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archsc=
ripts
>
>as its prereq=2E
>
>Judging by
>
>59b2bd05f5f4 ("kbuild: add 'headers' target to build up uapi headers in u=
sr/include")
>
>it sure looks like "make headers" should be for uapi headers only=2E
>
>Oh, and it should be documented in "make help" output btw=2E
>

Yes, it was more of a statement=2E Generating internal headers sans config=
 is utterly bogus=2E
