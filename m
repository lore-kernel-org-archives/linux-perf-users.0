Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794422068;
	b=rUmDnVUz4gZb5FGe1gghI0QjxGmsaSxAS2yT/YE2JqpIXWHxpunHjbk9wVqYWq5G+4KM
	 6ZTHDfJLyXcBWco9QCTTWrRKO+6E1TGBOU4qR+RWFGijKvXzziWLIEFsk38yUb/vqDdKv
	 ecCd93RBdIT6KFfEKYDp3aUZ+XgZiq4o0X3j0TQlzPlrqsxgEKTUI38fyCY6ZkGFFmSyG
	 i2kNUdHnzhbwQBezs4FygZHTtsdac6hZmLtzVBOhjxBT5I9soHL2+eZUpBWYNCW1DOQXZ
	 V8M+c1bTpuZlkkN2zgvqUNSuhVCO4ffAaUDMIyYSRmQQtOhkhQ9ns3djyJt/Vl6tzBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2Z49rE7knRUVwWJJdCKoamYrHVBdYg7n0RJDkec0CdM=;
	b=lrdyBGhgIHpB8SVjdnYZDPLCwbKDLYztJdTf+r574a5YkM/z/Ps/M4Y4gyzr/OLjt7wp
	 1Axt9V2/Ffpa1SEvuLSY/rtW1K1v9a3N5ctSJe8GkAIBO45GgAwyMEejLoQAZfW/4B9LW
	 21Kzk7h+oB6Srlvoue74y9WNRba9U0JRF0Wv8AAjB7XS+COoTh5rffcXVZiyzjuKuP+hN
	 0TEGIFFiY+z/hnT0okwh8EFtjmDKWbw1LiqUe/L1QYuST5l1qyHd8c/8R9QwPwjKfwgrP
	 OTaUV8m2daXa2Xli79HHfbT6YbJChK7LcVc9ehAhDxyZrl4Cwv8Nr1aTfEPZA8m6w9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IhpFTLk7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB58606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 18:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DB58606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IhpFTLk7
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a8cc11ac42so3460322c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 10:34:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794422067; cv=none;
        d=google.com; s=arc-20260327;
        b=sSCJpvn8p0vb2QpAqvwN+YKSOxCcRTBIBqo9ZC3kyG7je0ZdsJtFEh5YD0WQ+KfXIq
         kCpVhiO38m7pOBBCVMMsnpwMvEuxuliGy8rqjQFK2dLZCDuaPqBMFFChj1FJpWDKnFgx
         LquABY11iTNXylCANbN8fzFrz7a8j8XzO5AD4LPA1enam/kHfHnSehUtgnw21FELZoRD
         H7e1pufWAfPQPWHTdkuFSq0JoViOEJH2vckmCAdGfNWT6tKvGz/VaRr4+6zVgZ+oxR0h
         HnoK6p1+YP4KWa1lV8dVhG+MHaTuhqN6c6P18gaEDjYSNg2qzXi1hK8saMGGYWFKwXO9
         4YIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Z49rE7knRUVwWJJdCKoamYrHVBdYg7n0RJDkec0CdM=;
        fh=clabjsyAsWKJW2h8DzOV97X0wuePTDm2INx7XTe8i+8=;
        b=TegzIPdza8SIW7AGoYitKVxWsc6cjO34Rcy4C2cQQrYJtQuWT/ebrxmni3804v3suq
         gOyW2kgtTsaO+0WOExtzSGpOoX6bYjMZTd6PYwAGnOLp2irNcFsic6c7873I8OoGLfqz
         fP58CY7YFrA+Vz7jA+hu1+S9oZcg3cr42SRddZIF4E5lpZybwvaWIJ//DkSwqDrBBrgL
         TKLIT22Mi2J3qck0Jv5U3fYvVsEnQMI6jrUifQP12N4IZBSrrg+uC1LXPUEm+Q97CcwZ
         piBZYoICQ/F/qjg3LKMPUjqIDsv/ZSa864gf5vz9TmmylgV1NxVwNFc9Xasy8+8g6R/q
         9MCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794422067; x=1795026867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Z49rE7knRUVwWJJdCKoamYrHVBdYg7n0RJDkec0CdM=;
        b=IhpFTLk7qHte3e43EzKiNlKZ+bx3uZHj2CBmlk96Zb7hV8J8S2RqYhI4MkxQ26byrb
         4S8zlRPOf4732/meC5L1oYABZ4uT68xcSgjeDtFJ8pHha/t/wxyx0MothNE8i3C3zbG2
         qea83PTASZLdBdAwQmLZ5sqPcsV8GQDQm6v0Nedz6DdHFRx8Br8MBQkBWjwCmN5Az6wv
         BLJwzskT9KHbyyO//cFx5ivxSkgHuxL7PJfbJv/aIRj03jzaSd/PQkOTyD3Lu2kDwz59
         piht//EewGePWwM8uWhEAoc1s6nwxu/5S2C+tYBxM1Jx+K4gTmkNcTbgPiSulUYTwMt5
         PCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794422067; x=1795026867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Z49rE7knRUVwWJJdCKoamYrHVBdYg7n0RJDkec0CdM=;
        b=f9yGz4qINOwzSewRCIjRs3PA+FfDYmjKm8VhUI7DwxDi5X50CSvbpfVP3ZKG8KgrFQ
         JszDtxuLnlUnBFD5tZgIWgpZ0H0Hek61ZxAyMIWlgy09NJzbFKc43dmTB0ZlmxODAfIt
         qbckX7cIJce+s0Z9GUi80EvPNB+FbNLMu9DvZYu78b90ogBPpldPGHIzM6IHyJM8zFHL
         kYYySl/Zw8fpSOVkBWm5haWlgTZKW1fVC5fY/YSo0XtwZsCMVGT2XPjFOQC/CkVrKW0q
         FhvC+0YDfXHlulGUb5hH+3CaRauDxlmhhL8qYj8PdxsKmZGboaAdoSg3iodNr+iK0nra
         VQIQ==
X-Forwarded-Encrypted: i=1; AL+hErHYO+OVe7rBeaDx9eeUiu5XsZCVFdKLSZrdTcgFoJ1mmb2c8OEIFk9Ee2upDkF67vO4kJle/iyj0Z6m8xfnYYdJ@vger.kernel.org
X-Gm-Message-State: APuU4Z+EZVN9dCRL/GCPghJQIrWGCltJoPGb0noDhzLLhChmm2t37MqK
	VdPv5FXNulWaq0iBj6QjYzk2nCclOKl/6wOtFmOnp5cLhM2LHZ3aMM3tem+TtITVOGc5Kpj38D0
	QkxvgFa5wgc8ysrC450ifPyddhdLPpB+9h84HLZ9T
X-Gm-Gg: AYBFou2pmQs1nT3iRvJLWGCvQAk4ljcZoyQbYyfQKnR6ytCjMnYgHjSIsy+fHLI9Cr3
	ArCm0ayQwJ6qJRXLOXoM8OGJZVXb7vgkD8evb4KBypLtuiBQUEKjv86JxNTBtQ3iuOzKHkqYvNg
	tpvFEHUaq24uf61GRj9dszNvP6wRTjQB7UnqFRZlumG1flo72KDCDpVucZCBLJAyn5mmYorbQYX
	1HCPhbRuExHdIT6/EOEgDrEtlLgCL8wuXo9udtTSBFhIFF8j7SZfKj9hiUcPYLcY+PGuDjvqeZ/
	P3s0QDUPKomsQQX9li9WhJ0jDFUH6di+z6zJNxGcdCvpBAprdXitOd67MWxawghKTfEyzEv+sxO
	2C6HqilGFuZBQBtI+umvaXtUxdBjDFZnlZmEu+tLCiGZHo+OMKmwG3jY4eHxSLHqlfx4=
X-Received: by 2002:a05:7022:290:b0:1b2:529c:5b6c with SMTP id
 a92af1059eb24-1b3c02f37ecmr2924192c88.14.1794422066151; Wed, 11 Nov 2026
 10:34:26 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030192537.3079368-1-ctshao@google.com> <20261110032240.3080302-1-hang.zhengyang1010@gmail.com>
 <avQLKYycwzv68fVf@z2>
In-Reply-To: <avQLKYycwzv68fVf@z2>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 11 Nov 2026 10:33:50 -0800
X-Gm-Features: AclHuK_lKHnJ8g7uZPZXmOaZQmv-H33wU2AldAbo-s9XEVltjHPvdW7uP-BgiAo
Message-ID: <CAJpZYjXJO-vR7ratedregLyeqk372Bf7V89zGWGKjJ9r9csd=w@mail.gmail.com>
Subject: Re: [PATCH v7] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
To: Namhyung Kim <namhyung@kernel.org>
Cc: Hang Zhengyang <hang.zhengyang1010@gmail.com>, Ian Rogers <irogers@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Nov 10, 2026 at 11:22:38AM +0800, Hang Zhengyang wrote:
> > On Fri, 30 Oct 2026 12:25:37 -0700, Chun-Tse Shao wrote:
> > > When running `perf stat` with `-A` (--no-aggr) and `--metric-only` in
> > > JSON output mode (`-j`), [...]
> >
> > Tested on AMD Zen 3 on top of perf-tools-next 13a8d580433a.  With
> > '-M l3_cache,data_fabric,iotlb -a -A --metric-only -j' the metrics are
> > now on separate lines labeled amd_l3, amd_df and amd_iommu_0.  STD, CSV
> > and aggregated JSON output are unchanged, and the stat linters pass.
> >
> > Tested-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
> >
> > Two changes the changelog doesn't mention:
> >
> >  - Without -M, 'perf stat -a -A --metric-only -j' now prints two lines
> >    per CPU; the first is labeled "pmu" : "software".
> >
> >  - Plain 'perf stat -a -A -j' gets the "pmu" key too.

Thank you for the testing. Yes it needs to be fixed:

```
  $perf stat -a -A -M branch_miss_rate,cs_per_second --metric-only -j -- sl=
eep 1
    {"cpu" : "0", "pmu" : "software", "cs/sec  cs_per_second" : "1211.5"}
    {"cpu" : "0", "%  branch_miss_rate" : "1.3"}
   ...
```

The fix should skip printing `software` pmu like `tool` and `cpu`.
Also, PMU printing should be skipped in non-metric-only mode.

v8: lore.kernel.org/20261111183209.1892421-1-ctshao@google.com

-CT

> >
> > Are those intended?
>
> I believe it's intended and looks fine.
>
> Ian, are you ok with this?
>
> Thanks,
> Na
