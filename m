Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501662;
	b=KSxhkLIryGUHzqFoKqOQZpgZBxp+RPM7yoV2dRc7ChIbMq5LMawK5KSeR2b8qqcV/d97
	 fpSIHAtG1IwwaD1lkn79SJvpxNQwg/oQsx3qnEwUwfI0Q27WyuOhS5cAhbt55JRy0bocs
	 cJEm8wV8b5Oflbfr0NklB4/0Gi+hFlMmPwUYIpMjYmB0mF0WEIWoKSMLnYOPy+H4aJXOe
	 vXqKYuI3DxwudhEmBvkjILnFd5/hnOVAvDNhr7XFntl+dXCPkXpNl46QPA55x0gsImKB9
	 5oDTt6xoe1DJdHT7NmLInKrl/Tx0geeLLEpT9M5jWW/1cKXlAu3opshRZgAfhUOSSpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IBC4BwbngFExwxTmiTkfTdZarJDe7r1VPiz0JfI2IbM=;
	b=zI2ZeJ7i7AOe40K9oGvO+eNlqfElCZaL2ow0cYWjJG+JnGz12GRcFV06LI9HL2QYS943
	 S07sorSk1Dsd4SDJEVG+/dPHakwEkiNzDaXeJF0i2mxHHm0h4THNero/UStz/xLG2SMAd
	 XxgUD8mwwsV0LBOCGtF1gtYVSDKRs0I9lPrnqcxP+f+kWRuby2xnKzEwe2zVsYYT6GU52
	 uo3O8L21wj4XkazvFb/1o1efGyMNt/COwsODP433LR3cr+MtSiVtCx7fYayhYgAgS5zO9
	 eG7+cudrZ6H+wwnjf8XqRNUQaqC0zWgEZW2fHQKiZ4zRw5bDgqAWjOvlQ8h2+9uyK2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vjZvUhJ1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466D760A2621
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 16:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 466D760A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vjZvUhJ1
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dee593f18so3599783f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 08:41:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794501661; cv=none;
        d=google.com; s=arc-20260327;
        b=H6Ar1Crflm0YzjYlK4TB68HPT6fhlQ+7G4FrRj/0aFngHsYIZcMvO/qrAwAsi0AlYR
         aE6kiz5H4tsnTCS/Ze3+gw9y4g7uzroh48ooxkHDAQxnFvKEybMAdjE0G5SxA81O8Mkr
         w7rDUl2ntOsUTmubqrSBs9HGhJtMdY40lSdHAQ32ox+YVC0hy06GnMBUntyR/ZMsI6/h
         dwx39IeCaD6srfpBwMmIbN1RvWXBOeOQgsCna6eRipVE1GqFaa8LimmG1mmKVhAr/E+t
         LRyVHvFfZWhVrAHXNjwf+K2bGFpNqn1JzbHJdgsIdE4qPfyhYTDZSL3Gx24Hne3dCFk9
         8LjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IBC4BwbngFExwxTmiTkfTdZarJDe7r1VPiz0JfI2IbM=;
        fh=ck/GffTmn8aMsmU/rTizmZ4PUo+iI0hwmAvmoWx50SQ=;
        b=ZQnpwL3O+pJYRh6vcJzXoQDGk/+WEOJFYt/Cbw03FGqUxBoWGozx8DkMs/QbPmLM2E
         Fz90JkftDhGwyhRloGPu81T7+X7d3nWINU/j93weuCaQW11GjmAC/piRNFIGsFFiGJjH
         eTgOnH9hTEY7HBSJ9nNqQsOraic0tLC7XKBEAH5k0muRZC2OY8Xa78SDZEYEsIAyhfvU
         0Xw9kJgB9++yDXuUASekX/DKcREYeoTjchOByGqhd11z9ZMWUAnZD94wK2dIEm2vw9xx
         xaIgnU0TnyKTcjxCGmYokfPtPVAvH6N8O2QryC+GeDpAZZRMz8epx9VOgmNwvBiv+o+A
         82YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501661; x=1795106461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IBC4BwbngFExwxTmiTkfTdZarJDe7r1VPiz0JfI2IbM=;
        b=vjZvUhJ19QRU+AiKc6KMqW190hVpWOlrqhNDnTZcTTSXb1vtsAZPTM1uV2b5maBx2U
         RQ6yt8kOTYsT6PGh0oGC42EDyYtvkwLhliyWJuemfr1t6x26L9ZAWHB1CmzNmL3Su/+E
         lkaTNObDft8B2MWiSaGlQMv8rldaSsccfa7O6zbRpisgLeLI8fm/DfB21zF+Nx3Jb4EC
         iOWaines2gkUBveFbdyoEWPkgxswH10MCvWwKgXMD0cDeQHgUdvQP9B0WuqvjNxvTdGV
         pLNJcnMiJ1x3OY1pPvS5ZUOIHIBCHKi0T6nbKAR8TknmO2hmVCjohr6sM12jhueaWZBP
         l2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501661; x=1795106461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBC4BwbngFExwxTmiTkfTdZarJDe7r1VPiz0JfI2IbM=;
        b=c9cPMu4AFZZYA6wXgkc8Kt5YMosuM3AXTxB8oSOnakstP8l+oWuOnp54OiEj9faXll
         GcayYXY8M7uNKGaBrT1mVVgIlySS5BRcSIe3E6za6MAZcInyoM1nUrpfHgOlnE4kSfVu
         6fZkGX1Ss7wbtzPYRkh8C4VV/g3He2yzEvnoffacyl3EV/eZUuzJ1Xim67nCclkJ5yUs
         Z9lIOPxi+Nflt8VcN0ebHYugEybH5O1xiesYRlcjnb1vwPDeJZxMbASfZzO2J9QP091k
         HE0r+SSAH7hnGQqx3vhBDK1/WY0/Bew+NVs0snyC1afUMt25MEEhURTuciW2L2twIgK1
         5yAA==
X-Forwarded-Encrypted: i=1; AL+hErE6qfKwaaHk1XohR/ltiWCCHNZzl3cvYgGzZeGLNRhcAQPgtaTz4s8RpwZsmPYbjrNJcMtSvgb5X7zh95XRyqBA@vger.kernel.org
X-Gm-Message-State: APuU4Z+wLbaXrjJTeD9WjxZsXLWw6uAaZ3d7u4XpzDkpyt5qu+QbRHlZ
	FyJwqvZl6HmGKxsUg/YIIJosb25C9epwcj8TTWiUAKuoGnTKSeEGchYqWdpEYalaA23acrhTRZc
	MsP4UcugrWKOcDxfxcbxDaTVgZb5dCvI=
X-Gm-Gg: AYBFou0gEsoI/yHQ83GQ2vm8enB1MmqnWZTjdBEqlgnshCmOfO8Mv3kS9qnFpMI0LkT
	8AYZKJxCKGXU63RICPWgyPbEemtz8z/f/qc6VDhvihmK/UeZLWD7x8hCp8STldDXDbT/psgMw1W
	Zlmq9q3Z6Fyc5OBTr3Jif/ldmz1972zB2/pZybcXneBztF85nILDEP4EVdNJXnXoTxLy0EsysBj
	lR44BUvgPkVWSgi7+cAwGFmWYCdqwrSdAGmoSeVv1XzdH2PoXcHGnoIqIyXefrAo/RxpRb74Rmv
	gjTpXzLJqemGTAy9Kgif4fbcssDitAdwBC+8/qZ268+LNH4n0fkZmP+SF0xAgoHYJMs4zWTg58c
	BVkjGnMVY7BuVdcGgwnHZgoB5lH92zVllyFAD0L1WXqVlHsGQTnB307mSinF4qxTgbJfRL9Aeta
	Us5L/qNeYwnMnlJOGEBT9sZ788UTrATFAvTg==
X-Received: by 2002:a05:6000:611:b0:48b:9d2:1a6a with SMTP id
 ffacd0b85a97d-499c5783b39mr11321286f8f.1.1794501660442; Thu, 12 Nov 2026
 08:41:00 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <b7456dbb-16fd-45b4-8742-e9ea3f896317@amd.com> <20261105170340.165507-1-puranjay@kernel.org>
 <CAEf4BzZeVd4boXX4Hy1sKAM=dUPS7dvdmrOPybGrrZV+bU7eAA@mail.gmail.com>
 <CAEf4BzaGnsOhpz=bOxoSEyy-8W0epd5Go6juimoqDge+Rc-+Dw@mail.gmail.com> <3b28aa06-1496-42b1-b1d2-c654c7a1ff0c@amd.com>
In-Reply-To: <3b28aa06-1496-42b1-b1d2-c654c7a1ff0c@amd.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Nov 2026 08:40:49 -0800
X-Gm-Features: AclHuK9lJQZ7h-Tjy7NgKie2ud-WbJ_QiIASQW9r183XyGzAbFbdqxpFP6zjSSU
Message-ID: <CAEf4Bzarzbv+Dyg4poo5BM1pjsBT_ggycP-Wrafk5fAf-F2TUg@mail.gmail.com>
Subject: Re: [PATCH RFC] perf/x86/amd/lbr: Don't freeze the LBR on PMI for
 user-only filters
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Sandipan Das <sandipan.das@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 3:09=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> Puranjay, Andrii,
>
> >> heh, so we basically either
> >>
> >> a) opt-in freeze with *new config*, but do it *only for non-kernel LBR=
*
> >>
> >> or
> >>
> >> b) opt-out freeze *only for non-kernel LBR* _unconditionally_, but
> >> without adding any new config
> >>
> >> In both cases we have a behavior that makes sense in practice, but a)
> >> adds some new config, while b) doesn't add anything. End result is the
> >> same, just more configuration and need to change user space code to
> >> opt-out the freeze.
> >>
> >> Is a) worth it, or we should stick to b) and keep it simple, Sandipan?
>
> Have you run a PGO experiment with the patch, and does it show a
> benefit? Also, have you seen any regression in any benchmarks? If
> no-freeze regresses some of them, we may need to give the user an
> option to keep the freeze enabled. No?

One of Meta teams internally reported that disabling freezing
unconditionally through the kernel command line showed a lot of
benefit in terms of data consistency, and I don't believe any sort of
regression was reported.

If anything, that same team is asking to unconditionally disable
freezing fleet-wide, and this work by Puranjay is an attempt to have
some middle ground where we don't have to do this all-or-nothing
disablement through the kernel command line.

>
> Thanks,
> Ravi
