Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708422F5A2B
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763987670; cv=none; b=LArjQa2+khpMMLAZLtXiVWJ9pBPFlGfImwdwZXfYdQeQ1QdsDvmGHbHx52FIpGfbdyxsBAn8fcinr31wLij4aT50Ovw+1dJzNytnE2AbLKNRdzvQ5zh5EhG01cA+bHLIavH3AzHf6LKSc3IEQLraou+1DLvmCHInqMJOMuC/1FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763987670; c=relaxed/simple;
	bh=NqJVpgRsISEh8Z7VAZzRM5TIO+Dza6dvIHpwqdK2H1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orcpXPZUSbQcpU+V8bdGYy7aeqB9Bqvr4N2iG0fUTNZ0GT8qjJmk74dHj5ENYMuRvwd7WT4J0mzFvxPzckmNogmr40vVDhUzIK1xgdMDJsfMrpFeRlKf590tARr7JGS0FERHJWUUci70Y6MUNTyftOnSVyo0qQh9srGtR3d0U6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fU9TJ4c6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=exSL+nuk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fU9TJ4c6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="exSL+nuk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763987667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKuEsu3DXM+BpZucj+j9iyYE7lXCC9H5X59q9NOsny4=;
	b=fU9TJ4c6Op27Vnxf6S9rEE1ZCcvKPQNVBsroZ+6SfAIIQsd3DMbZHgsHUYdRRG1AM2PiWX
	hXi6NGkNN5X8s+iFV29qkEyRGpJ7UbIk56Dvigy1JtebTs0QMeNHVqGNXLLNKY2eutugTY
	jcefadNT86hpO2MMBZ0mtbDy3a4P3k8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-mLI665vSMWGJG0kKDgndYQ-1; Mon, 24 Nov 2025 07:34:25 -0500
X-MC-Unique: mLI665vSMWGJG0kKDgndYQ-1
X-Mimecast-MFC-AGG-ID: mLI665vSMWGJG0kKDgndYQ_1763987664
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5944b3cb6fcso2765385e87.2
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 04:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763987664; x=1764592464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKuEsu3DXM+BpZucj+j9iyYE7lXCC9H5X59q9NOsny4=;
        b=exSL+nukZYPqm7g0lVMD93jrWyVJY8oKPYoyjR7+sA+vrlsqj8BTn8/gL1EqsjKaP0
         CYjrQRZxsm1Y3rmpfs5rAXLyvjQ/lGXJW8mWFVl6C+hI34+f3shpnZD55ysqRBqpp6ZO
         3dAefH+X5tb1MsSmcqFJFAz5UzbPmJLOHSK56nV6T831PLzOFgF5zTS60b2eRaIH6i9O
         d6MsIOW+5/+BiTyV7+7pF9dCz+9o5569PG7S3S6tQYHVBsQc2h79FcyMQ7r93kcBf644
         tYsDrDzrdxVqPZTdsZXP6nBmnLfLSgV/EU4cQGqYM4INLnrqnJ84X9Icr+5ZkIGm1hBy
         3FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763987664; x=1764592464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vKuEsu3DXM+BpZucj+j9iyYE7lXCC9H5X59q9NOsny4=;
        b=O8LmpzNw+WXbGfW7UNfI6HKHUn9fQxTjGix7jRsxf+UiO1ES11TtsOgDhITtmjkREk
         ntJVuDaKzm3xw3BkzkyNWx7J6Xro+16CnFnuD1O7QT6YnvjYaFdIsJQJdUtr/MC0swmP
         fHVPQkdN4AKRBifdtcAaOyon6d57RtWbhmxEBCpYiowBMsckbdoMqjK1AxJZ99cafMO5
         wspGXhDotWqnxUbN54Xffdq2UIL80UhnEtYrBWrWxVjjG07AOTkFZqTKUKddSy5hKHg5
         pVOSyXNjdP9xHzsRYVyPwrkOIw2nwpIZ1vr7D78tewlqWyAfmeeJqlkQanYLeqWFdMJ4
         FMUA==
X-Forwarded-Encrypted: i=1; AJvYcCVIOfl7GAGQCeikrrPHM1M1B//qNm1qbj2K9JC7vdRxaSxEngYyzgvSn3rMckTq6gLtjEpVxBSp+Tx60GRs8pN2@vger.kernel.org
X-Gm-Message-State: AOJu0YzZUhJKQXeCSwSAPac+Sz1cdrgXAerO8txnTgCQWVu/OhwxIvCa
	ANVvSW+xMOv1BYQPUzufEmX6wc+lJUeMzCpo0mee+wPV9S+Eig0XWZ+j9wCUU0PKzH7Z7hbJ5o2
	fGaDgM3CZCCr7AKHrp3boTZHlBf9qrzxMN1Hrxy80iAD4Yv/ZTjjAKTjq1X5n3f789FStYvr1X/
	q9LYnpZ7Lq2Gqk4XgblA8NW4gf8ygkoYj7V03cdu2K7/tung==
X-Gm-Gg: ASbGnctk8FzMxGw5nJjMt6C/mr5vIFmsn/E1BIWo5dwaDSp4g/yxj7k5fm/UY5XzF3m
	5icn8P2H3v9/dXHKXKRIjc90iSu4vBfIHp9XwDySEuhid56tyRJwt67rcXmZAvY1NobrpairxtI
	MjUlMxiEDLcb+vivPrB2m/wXIUYb0HyGCjTaaeK7Ntyloskgq20/dumw+/c0VFXr5F
X-Received: by 2002:a05:6512:398c:b0:594:27c6:a23 with SMTP id 2adb3069b0e04-596a3ed314dmr3564776e87.15.1763987664310;
        Mon, 24 Nov 2025 04:34:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3CSC+PAK0IgzNSTtEMpEzfvCPmHoHiPt3hWTD3k3oXDnFywyPVk/0W0AUCeTNie9GdlTM5JF9ZK2AQ3w4Nkc=
X-Received: by 2002:a05:6512:398c:b0:594:27c6:a23 with SMTP id
 2adb3069b0e04-596a3ed314dmr3564758e87.15.1763987663866; Mon, 24 Nov 2025
 04:34:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114220547.496562-1-irogers@google.com> <20251114220547.496562-2-irogers@google.com>
In-Reply-To: <20251114220547.496562-2-irogers@google.com>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Mon, 24 Nov 2025 12:34:11 +0000
X-Gm-Features: AWmQ_bnp-1fJlQ2Mibxrc-o7Ns2s5Y4dWfSA4L6o59dRqabh177roHTVEEcgzJk
Message-ID: <CA+G8Dh+wLx+FvjjoEkypqvXhbzWEQVpykovzrsHi2_eQjHkzQA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf pmu: Add PMU kind to simplify differentiating
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Howard Chu <howardchu95@gmail.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:06=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> +static inline enum pmu_kind perf_pmu__kind(const struct perf_pmu *pmu)
> +{
> +       __u32 type;
> +
> +       if (!pmu)
> +               return PERF_PMU_KIND_PE;
> +
> +       type =3D pmu->type;
> +       if (type <=3D PERF_PMU_TYPE_PE_END)
> +               return PERF_PMU_KIND_PE;
> +       if (type <=3D PERF_PMU_TYPE_DRM_END)
> +               return PERF_PMU_KIND_DRM;
> +       if (type <=3D PERF_PMU_TYPE_DRM_END)
> +               return PERF_PMU_KIND_DRM;
> +       if (type <=3D PERF_PMU_TYPE_HWMON_END)
> +               return PERF_PMU_KIND_HWMON;
> +       if (type =3D=3D PERF_PMU_TYPE_TOOL)
> +               return PERF_PMU_KIND_TOOL;
> +       return PERF_PMU_KIND_FAKE;
> +}
> +

Looks like there's a duplicate check for PERF_PMU_TYPE_DRM_END.

