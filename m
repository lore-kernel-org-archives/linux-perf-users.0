Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B60E211A3D;
	Tue, 25 Feb 2025 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515481; cv=none; b=UXUYgBR9PmLuAEJbTRXRJgr9UmWNwb4RgdjSoPK8MsioJ6NSF9Q6TJY6K9+GOwqdVxacx9y7qByxI/ecFKj5LGHEM7Dsr9CrzFgS6AbDwbeqZG2gOxVzY5zq6d0uu8gScpPY4XBT3UvcpbkBOVPGveBzAHw/btgYdYOTwghSeQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515481; c=relaxed/simple;
	bh=Q3MY/GdxKQqMGIPyfRPgojKwDuIC8+anQD9m52JAilg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cWTT3/JlbRZjYnfKfo96bGzDTGRRoLJ9DUzbeWWipO5VDQoweJ/mvW9klC09HUL5FK+RfyhqkYuVALPvXCarFPAucS/9B8kbzdZm4Er5CmpIvYyRhbsXjJuSecacNn11DcdP3zz9ognprAEdzC/cN+NVztkHhPOZJtiarpDRYnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=OwOqSvQS; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OwOqSvQS"
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51PKUlSt1422052
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Feb 2025 12:30:48 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51PKUlSt1422052
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740515449;
	bh=Q3MY/GdxKQqMGIPyfRPgojKwDuIC8+anQD9m52JAilg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=OwOqSvQSipLIU+p0TxT+2SjwwKvhADNhj93srBgQ4E64s38xGb09x2XBPNV+2rVYc
	 fZxUmjSHZGG2IXC7AUgzreXFcjXK+wDaOWZxXeNfSJfKVYStBQF7k7AdGBYnGlBZ7+
	 4RES2rlfJhTOfePpphsx6FsPw+Iq1w2FofpiBlZAo+wOEayVBFn4OLG1MCsOFkkAFS
	 bVEzz5HL+/gaNq8uqbUy87nX0HNA1gvK5cQZOwY55ELN0Nlg+02xMtwGowRfM5N466
	 E5/5p2vUt4842AaTO6UkikDkYcOtRkPvCrkQBAhVLutvrTMHXGLHjD3bpzUrjxkNbl
	 HerTwdNoTNRsA==
Date: Tue, 25 Feb 2025 12:30:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>
CC: Nikolay Borisov <nik.borisov@suse.com>, Xin Li <xin@zytor.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, will@kernel.org, peterz@infradead.org,
        yury.norov@gmail.com, akpm@linux-foundation.org, acme@kernel.org,
        namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_0/5=5D_x86/cpufeatures=3A_Automatical?=
 =?US-ASCII?Q?ly_generate_required_and_disabled_feature_masks?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250225181551.GDZ74I1we9xqM_oj-b@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com> <20250223102723.GAZ7r4C7C6sTUnbe4I@fat_crate.local> <1a444a2e-75b6-46f9-8f38-0458655873ac@zytor.com> <20250225174915.GBZ74Cm2Xpc_WwS3oe@fat_crate.local> <8973bfd4-d8b2-4dd7-ae1a-3f685dff769f@suse.com> <20250225180051.GCZ74FU-PrcosEHZb1@fat_crate.local> <A8B4322F-F298-406F-8F84-9151FD3CEA5F@zytor.com> <20250225181551.GDZ74I1we9xqM_oj-b@fat_crate.local>
Message-ID: <1BD9B089-9500-4956-9FE3-DAE75B2127B9@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 25, 2025 10:15:51 AM PST, Borislav Petkov <bp@alien8=2Ede> wrot=
e:
>On Tue, Feb 25, 2025 at 10:10:03AM -0800, H=2E Peter Anvin wrote:
>> Yeah we had that debate back and forth=2E Although I personally feel th=
at any
>> sensible build host would have or be able to have Perl, the consensus
>> opinion seems to be that if it can be done with POSIX standard tools or
>> host-side C it should be unless there is a very strong justification to=
 the
>> contrary=2E=20
>
>Right, Xin, please make sure you put this rationale in the commit message=
 so
>that people can read it=2E
>
>> I guess at some point that will add host-side Rust, which will be fun s=
ince
>> that adds the whole Rust user space runtime=2E
>
>There's that too=2E And that'll be even more fun=2E I can't wait for the
>compiler-specific workarounds=2E We're having a lot of fun with two C com=
pilers
>already but who says we can't have more?!
>
>/facepalm=2E
>

Yeah=2E See the thread on this topic, where it seems that the Rust languag=
e people haven't even figured out basic things like their aliasing model ye=
t=2E=2E=2E
