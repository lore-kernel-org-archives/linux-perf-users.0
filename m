Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738177;
	b=JYwhItyoo8TOBP47vWZcW4JRa+K22EfJHtCWJK77Xut9zwnSp9Um/7ZHpXd523OX3xwz
	 K2P8TkY62lzHQo/stkXpdWT6RWlp/tzSCJoGB47GuQDz4q61VDxwePea3+c9IurqXS6pJ
	 linzuVJHFocA7RrWq+vUUUNg60eoMmLwoIU1HuAoUWDxziPkEx7B6gjnMq/CYulOP1gGq
	 nXhPpA3jcDU/0DW18uDvJDyfVBvF20i0fF1tX2WodU+0kS3i1PU9k5D1TTyMhWL7MtH6t
	 7S3595fFV/y8pt2/3JeNpSm/lRp1LrgNMzDE7KZbjrp4IAfiXm3STVX2roJsI7EOVTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xQ4+oRgLtbqlKeiqs+JELHHN3xsV9CKXX0CLSPpUZjo=;
	b=KH0Tc8R4fe/pSsrgajnUy3UR+yBKOKywIMX6vKDJcdHS5Tm5DBuUjbayieqsIJHnDIWp
	 L60L5YkoxwNs+en/59CKJyFt9Dwj1114Jb06kd7Eti6D0mgnT8Lh+0PWb8kZhoWgxu1pN
	 XRPuimwA7TWo/E1/rzTQTLZI7ayl1sZaO+3TZvAbG0MvHkJ1+piuCAAyaLQD9mheJ6vOm
	 zhQYXtyfcAo3m5nAlvZydAJQRSZ0B3QC03YzTRatQn7cDBYSuXfodaXMT7tftdDINRAdw
	 aWW92p2OoowYJfbS5AL6Dv2EoaPoMB2xIlxzuZoeJqFeASZR5+/LtdjxK25Xuz9244Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bf9JONb3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D01A606A328
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D01A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bf9JONb3
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ab3dd9667dso344271fa.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 12:36:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793738175; cv=none;
        d=google.com; s=arc-20260327;
        b=bsgR4Tkw4k5uNFuyCDCua4jKOgizF9Y/X6jnEJmtDMxNxyRrpcQhMsf4AkOvnXOzI2
         JfXtDaBSeCJLljX68yK8HMwYREu/gUro/uJ19afdoNd+kbSVv4NhJLFIRgpcN1goJ4z6
         R1Tjdc7wZlYoN4SeYgUpgv3kO1zkRUAhI5AH/0xv33025OFUNmyFc2Cf8LZhLatXyFVd
         kqTEB/eRPyffu5Q7S38dMmfe5vp9bqZSHR3UhBiHYlc9Zu0LzzZYexSdZejb4i0Knyd9
         4tZabpyjMunH0awF6sD70Lj6uY82Lh/OLcguEdMoeZyFgGn0r3ah6K2AZd5iIRvZW30F
         XuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xQ4+oRgLtbqlKeiqs+JELHHN3xsV9CKXX0CLSPpUZjo=;
        fh=hTSUpO6JTK+qRzFPU12u9goi2HASRH498/rv+eT480Y=;
        b=WIKQIAj6YhVTeuASp0OqLAOT2Xz8hZIPNP8O4QCBDTQwG9BLEcnXaV2DOJR1/TvQfz
         Ma6bI92nsiZyCxLs25byZvttYcqp3f7umDV2srD8phXqxBsIz2P+PX37rkCX6Kcr9G+4
         IXEBsEaZtGmCVUUC9n9iFKMtP8T77wty4JT4aGBlAonTXdgNI17raXC+sU+Y6HbMZwOp
         jE7BUl7T6mHRgLTzzsGHZG00K4tqIRFlorvB/GP9qmFSMQ1/rGhvcUx5eajWr06sVhWw
         URjVcDczeY5hGLiX48ZK1Bg2QvEeQ4GsOZtymd9FqBrJGJc33V1mze29BuuuKqqMLrTG
         a47Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793738175; x=1794342975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xQ4+oRgLtbqlKeiqs+JELHHN3xsV9CKXX0CLSPpUZjo=;
        b=Bf9JONb3tnHnffKYegeTecqFiyDWbdgWPTHUTayiSdHMFN5ahHLEdrlOc4Ka2yqU16
         r0wPdQz5WWPa2G8gHOqWH8WQAr8mDq1kdwkoPYPNgpyUTKN0ONz51fv/I+1MVfySyxip
         tC3LkYQD2rm+4thrZvujp/3VARnFED+6alYiLfHH1AlxX2CrBTURgD8BuzlE30WHqMks
         3jpHP549hG6Q/+M9EffK4JCNFIsFomDb+6hivIi/Kl9BWD3Tw/6FKwk/0A6TvPGE9HlW
         Dn4vT0JDBF7X158LdSpAemHTLXG1PUX0fanexjTn54/EW+UTS3TP74uiomxJHa2uLc2T
         mdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738175; x=1794342975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xQ4+oRgLtbqlKeiqs+JELHHN3xsV9CKXX0CLSPpUZjo=;
        b=KFlUg/C0cDg5OuGI5hZ1hfnHJME4Zz2tzlJI2MPMH3HnoErpSkroApAgtbkJciVn39
         sAnwUVEsdtzudTTFFRnHFs/MxkzOGy0aCVfYa/aQmxVPh5MDhGq4ZajmNu5QwNVo10UW
         qKcbiDmpC294/QxJYTi7CLi0o6zBYpZAT0VtvH7p3gCFiMg/uD/xZkVFYXfmkqO71fmF
         62A/iwbKZa2+nvd5E2+79Nm4SkQBU32o/OUbn63Ar2Cc2timQ/v40jCGKWtcNE51GN+M
         WLPqDC1fofO5k3JuO9G2C92yYMt0MF93Qx8Tok8Ow5cawFq5cwYd8IofY5eFjNaADXg8
         zHuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBTBTuUcIXndKX1Y5ZF/94b6AB3qyvcN1Gtfv4R/cmxZcTCbPFEIHjzcAvN++DiWhiGBCxlsoQIfnZto4umlGW@vger.kernel.org
X-Gm-Message-State: APuU4Z8kmetlBeTUVldNi1PPKkqOJbAaTR2Ijk6FsYiZq10M4L8uFlKd
	mzoz0AWA3Hpv+pxDLTgwaCnDzAn8ozKnCt5I8Cz6mAv6lttCkZlW/5T76Ev00SIL6JZfoIk+1Xe
	xJXQpwUtbqFQeWh/eRA+SkvhLu6ApFIk=
X-Gm-Gg: AYBFou1Mj3yVjkag0WbRUttNJtjOObwg3W1afzG7TaUTbJoeEZgOu8pzdDx7qbR6WGJ
	8w2qG6dLeLfEb4R1SnMWamDV96iFHSz4egihmst0I3jHSnXK9Itb2dr/xgJ81ugPG20e7QH6aHd
	E7Nkd6bCGHOefKOx62SqVNQtf6q7S4L8j5JS6l01LpVwHZOhOnEbroCH9p8L51SJ/oCgJ5uFXPa
	AwwNYhQHD0NdSAKMKHZEai61NR6KKsBGA+fLlNcNE4OeIuzIVkPR6T2MclQWj86pZGsVsyw8Jtg
	zO1JSbU6XTsPCvp5WgpKmWs5dy9sNPdrVBQRxfwGtWdgQ7TMbsj2TUp4T8vfz4KNQruSwxWl1FM
	NLyKwoNFRkRvW3SVrxNFH3+8/TA0uMRBhXYXDxbeEDK5Ix264oeZCCFNO18FRwufPqulPELiO12
	a8O11dCdfBBQ3DKX/1KFjYqBYMspZjup6c0XcY9VF51Q63GHFNddQ+
X-Received: by 2002:a2e:8a88:0:b0:3ac:4ce6:8b73 with SMTP id
 38308e7fff4ca-3acb7acf227mr31681581fa.22.1793738174621; Tue, 03 Nov 2026
 12:36:14 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
 <20261102-alpha-profileme-v4-5-61e00f5e1da8@gmail.com> <CA+=Fv5RgTNGzApgq-YcPZ6u_My9-c8T6xMjb-_yuQRV5C53T7Q@mail.gmail.com>
In-Reply-To: <CA+=Fv5RgTNGzApgq-YcPZ6u_My9-c8T6xMjb-_yuQRV5C53T7Q@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 3 Nov 2026 15:36:02 -0500
X-Gm-Features: AclHuK9vlMkzNd2fjRaApLlEuj1lZIne7iaoIdNdKx6zdWRN1ZXEG5eUPUtd56E
Message-ID: <CAEdQ38Gd4sDEtbUqSoy3QsFeQb46Bg3CZRzmPiGFLbSqLpxG+g@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] alpha/perf: implement ProfileMe sampling
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 2:41=E2=80=AFAM Magnus Lindholm <linmag7@gmail.com> =
wrote:
> One remaining question, should we accept precise_ip=3D3? For a PAL-mode
> PMPC we report the interrupted PC, which can differ from the profiled
> instruction. Should we reject level 3, or skip those fallback samples
> when level 3 is requested? What do you think?

Good catch. I think rejecting it is right. Level 3 means "must have 0
skid", and we can't promise that while the PALmode samples, and a user
PMPC in a kernel thread, keep the interrupted PC. Dropping those samples
at level 3 would hide ITB misses and redirects completely, which seems
worse than having a little skid on a few samples.

AMD IBS refuses precise_ip > 2 for the same reason (its fallback when the
RIP is invalid looks just like ours), and perf's :P falls back to 2 on
its own. So cycles:P and perf record's default event still get ProfileMe.
On my ES47, cycles:ppp now fails and cycles:P records with precise_ip 2.

v5 refuses it with -EOPNOTSUPP.

Thanks,
Matt
