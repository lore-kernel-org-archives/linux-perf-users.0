Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795046737;
	b=F5ayJFTd7RB68pCHw2zxFyLVhOC53dlB7u/V80IZjK4K5lUB2v+K3ddfdwNl2/njd8RN
	 sAtdRQl6dSfdmDHQUQSoAF7wuUFvdf1paWogeyl7onSVA5Dg1LogJdsmdTesQYy2ehoj+
	 jZ8hoq9sc4RBuvBTbjDMg54Igk/0GEpnKGBbuuusA0304bxHx+DJyJzUZzeGqngC47uXl
	 Sydpe14WF1X0WTOfJCY3+vsf9KQwKinHMqD/ViuEgu0Abn9WIl4OA2Odg/ePj7Eu+uZ3s
	 eeWM64HGpIPYbhmmq9yXEespRMLzWWnMtib8MXStKDJAZEJAoJtpj59BKMVwaudnedQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jSTBRQUn7y72ovG0FX2LVSDBSceycnY1ZcY8M/uPhmk=;
	b=V7BEhYSDNAEYpG/BQXjr0JCXbWvi/MLocLZrX2uDn61AadFu9e1jAASd+vI/aJUe/vyb
	 Hdl4cLNKuDHyj0+Br9yCPDPDXCclaOhoXJyc0nCqTiXWAfPpQGSvkuPhEavwf02OC8BNS
	 06ukMedMlAeHzA4hLPm/hLN/Yl9WfZdxBJdEgSHX9oZcEYkzN1ubj7x3HH53GVXbNE71v
	 NkQnDV7Yy/wd3HdWLc5nfGl5S4w4b929+dxoY2TIjBScNuPNaRR8g44bUvc1UOerjE+nO
	 O00YBUre/HXwMlh+T2qi/dEmR/MXBeK5Oq5sFiCmZldkW7QgiPogaQFYkVmwoCI/z1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlSNUh+q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3C606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 00:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A3C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlSNUh+q
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so1418967f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:05:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795046735; cv=none;
        d=google.com; s=arc-20260327;
        b=hUYbT3IAw7Uw7f/wpza+/cLvNA/HRPgwlH3zgVr7JJR4JNZ8xDBdfjoqjKGrw6HHJI
         5JtV7S/wzE3pRKs3u/u/GVTl3FihflkXk6hkCLdbSqLpAMlphkCDjoXyrGRvs/zIWLVM
         Ayl8UNpsuf74Pc+gN1OTB6Ol95EneZ0zrG4VD2MfqMNe6f9hXr62jMze1Ij8ubw1Ima+
         02NMIpOLYAz9au3mqm5x0Urkf+1CryfSIxHTa2kHNbdSCrDA54z0g0e1df/IPRQ5HOh8
         e0ghtIpBYnkGlDj/WU7M0qHNmNI+UJvXdpzr+ttn1vrixuxKLnVBqEQsLLtzpS1/QXrQ
         PBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jSTBRQUn7y72ovG0FX2LVSDBSceycnY1ZcY8M/uPhmk=;
        fh=jkSk376wXyr5NAgfNFpuiwgQlfR71D6dKVeZpOEV/JA=;
        b=M0d27Lix78ak4ah6mvjim5QYxfzj5BsPkPORgg7mBVh5gg6eH4W2j86JNmNMv4IkO4
         fZQtxB05zeIxdW2gx7tElPya9CvtNOr23Q8GeQc9/LF3J4XhrFORN1DFlAq4FlQT1+XL
         fFWZzmQZosnrSpWEldns9pABuRXfNqXNxIIKm4osdgLbUWUk5u2cHzGB+w2ONwpkVWmC
         TsYBl4gABeu3tzEQh2LtiCyhRqNcUpsacPdLwLePMdEwMrTEo47BdIEZbswaNGeD1gMR
         gqh94/YUUST37aKiUTgxBKq6CSbwnbQ27nc4mXBBCB/g2UMJRahy9WSPZ4H6IMYDc9tl
         0Lvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795046735; x=1795651535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jSTBRQUn7y72ovG0FX2LVSDBSceycnY1ZcY8M/uPhmk=;
        b=mlSNUh+qEThAmoYBnCSmjXkVGJip1b+KHtYsv1hZIFRn5g9lNUkXJziQ+IsrvZxDOm
         JC0nrs2S0LMH8+dx2n9zDizIoiSJHl/FgAYMzWxJGWzf8mE2E7TLY6V/Q8SLaw2zj1mV
         nyr8A/meIcjalPfDET3aMXgPigz7hzKg3vuVNXqnCkVXJAAeCCwQGT+x6VJ9AgXvS86l
         tno3FVEaAG2Om8RNJ6R3u041ds5tE/rhmvHZnoxDOn7ysC5ni2gII0dw9gihu7BkzRb4
         mFAgp7MU/t/nzAMNLtrlteobV8x57UJ7rG0WYyiapt6ac0h1jbaCEmVhXqxfK+5T1YJ4
         CwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046735; x=1795651535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSTBRQUn7y72ovG0FX2LVSDBSceycnY1ZcY8M/uPhmk=;
        b=mrBRSgyZxRIqCAQtmu8bOcc9R/dMPElGboo+EzDVxZh4R/mAPmDfT84kXowEl1h7UD
         YPycpeoDg0EBnpUi605pn/rR2dDyzB0uJqpGioVm7mNvWEq/LSW3ZcMHFTk9Xv+Kg3Zr
         oN5koDNayXExhlAsZ6dBjyK7iDAfko3wV0MoYFeDEPfV5K7BkjhctgYpQk7IYWJDh+gD
         NX0qyhzP/XgxHxoeCB8h0p+mjZP1II4FnLe5ORy82zz13TyUulRoGEjzY8FQe9lG/sMZ
         KrW6LTNdmpmBGM2QqBWjdIvm/BmNd3+3AMn7WVHFvNE/RGFeQX3whCTRWj4Yy8UCkTEh
         XiVQ==
X-Forwarded-Encrypted: i=1; AL+hErE0FsI+0m/bVQ4ttdzDdE0MkN8cL6+qFzker1Vq9a50YrWN84xLhF5TJWwGjd4pivfgeAfpgZmk+CfwoC+K80kH@vger.kernel.org
X-Gm-Message-State: APuU4Z9XwfpQlEKS1pTR+2Sbyft4+IsrYqehX1zx8G8/RbP0pQIymCdK
	UxYuly08sWV4BkmgQdHR1lRThNKw1KA+B/OcW2c0l6G5HmclBD8rt4eNUwew2IX/RIQMpEb1sCI
	MwHqSl7lwI3rvDU1a63fDsHKflKFkyEA=
X-Gm-Gg: AZFdTZcWbXamp1PLX37RgNnu5Ic+lFeg+xiPagzvoSWDCEyiG+iZsE9/ZkhLjoHz0DZ
	MqT8IZCV+IgawuLXkjqydgFd0QjIhUjsZdCEX67JAXtXZ5sS3KUKISAejMsrjg1aX3sNDatFkph
	QP0yqG+m0F+zaNx5mDermoi001Y2u9pem+Ym2iy4d86qbVROTnQFPhW+jr3EzjSD4drAK4ShRMO
	+JZRdqpTEEQn8PrdOukf9F9A6PdLRGSkoSB2a7z3LtSKWmFSkLNnR4zKgTyIZhvO32Vze06CVYU
	1qlBbQY6adKx2XzMK/msyJtukc+b9ZPZG5M4EfIUy0D/sdXf0AEN4w+BEggDjvCJcePTgBZCDEB
	+DMdPpgrlk33k2SU8O5PgYy9crWcepDm/DMHQT/3aYmxTa+l7I3scMapCrPKaZjYvoutl7Z6gR0
	nL6wL9TB+FfIaQFB3nvDg=
X-Received: by 2002:a05:6000:1a8d:b0:4a4:f86e:d97 with SMTP id
 ffacd0b85a97d-4a6337865c9mr9535095f8f.1.1795046735028; Wed, 18 Nov 2026
 16:05:35 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023124157.75524-1-puranjay@kernel.org> <0f97689d-fdec-4cf4-b6ca-4365aced16d6@amd.com>
In-Reply-To: <0f97689d-fdec-4cf4-b6ca-4365aced16d6@amd.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 18 Nov 2026 16:05:24 -0800
X-Gm-Features: Aa3M54psv0NDDiF9QLJFrAAgoAs2e4Ba4LlnjZXH_a2-VlxejVTzfB_OynEoxK0
Message-ID: <CAEf4BzaPDnopvSoS=AwN-gNPdzD0Bs4PvVPP+qCrdBFQ8CyJsg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd/lbr: Freeze LBR on PMI only when kernel
 branches are recorded
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 7:48=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> On 23-Oct-26 6:11 PM, Puranjay Mohan wrote:
> > On CPUs with X86_FEATURE_AMD_LBR_PMC_FREEZE the LBR is always frozen on
> > PMI, so the branch stack ends before the IP and callchain, which are
> > taken when the NMI is delivered. IBS rejects branch-stack events, so
> > there is no precise alternative.
> >
> > The freeze only keeps the PMI handler's branches out of the stack, whic=
h
> > matters only when branches into the kernel are recorded; without it the
> > stack fills with the handler's own branches. A user-only filter does no=
t
> > record them, and parts without the feature are never frozen (see commit
> > 598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")).
> >
> > Freeze unless the value written to LBR_SELECT, which is shared by all
> > events on the CPU, suppresses branches into the kernel.
> >
> > With perf record -e ex_ret_brn_tkn:u -j any,u on a Zen 5 part running
> > CPython, the function of the sampled IP differs from the function of
> > LBR[0].to in 84.3% of samples with the freeze and in 0.1% without it.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>
> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>

Thanks, Ravi!

Do I understand correctly (from [0]) that we'll just stick to this
patch and there is nothing from Puranjay's side to follow up on?
Thanks!

  [0] https://lore.kernel.org/all/5cf60aaf-2ee4-482f-9054-dff823710431@amd.=
com/

> Thanks,
> Ravi
>
