Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430CC1A6808
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632070; cv=pass; b=XdsBkA+SXFFVdwN4e7wxZXXnM1GH+IkA2ICDhjd4vU4/9mfj+MIrHxCjznLSz2o/1pF5uqBL1K7OFutk0T0RgxtxBzTFRI6w3yQGxD8qpAsAOeG5i7TRHYDCWe/ZdP/5iJT7ho6B67Dsf/Op7aHB+3yzs6PsnO+mAq0Ryh5sFcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632070; c=relaxed/simple;
	bh=W8+TaOrsHT+JUg3YhzZMTp0WQ2hfNYROQqVHdSTkueA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTcMtEMiwyyZ4W06iRvWvWMt5Wd6DNi/nAxL0N41f0JLkuvKGkI+m6sYALV2aV6wfx3JXd4A0UDG/B0L8VPzcfOT4JJtYvrllmUj4M8NCKaF7STHSYto3vIFFJfVudh0NHrtuavN3eB7rY5C3WGyD83k5cTsZvjQ+YVWOdePSZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8tz0/vi; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8tz0/vi"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b46da8c48eso1155ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778632068; cv=none;
        d=google.com; s=arc-20240605;
        b=K92z0vvtMTit8eXM72Pm7IwTBm3uJBYcg4BOe9C9HxdeBQOOkQA1x4UoPmr6GZ+tQI
         0KFgo5hF7x7T9r/1ZU6BF8G701g7/ITjGhINaBZAoZXR596IiM2X9Do7xcAmSt1e8hDW
         M76SKcGCEPhXfqNTlymApXKsYsI+Y/nu5Whas/d5TowfOe3PIbrLI7dcrQl6vSreL+gK
         zq0I/eRH5/CTq/5i/LvfMdsYwanTvFKmoQIe00IJd3HKofbezeyO5/6IaG4rmqznJN65
         iSmK49q3vu043ujlI3BcMXoWyHP3+RsRFbHBri2SexGfCaNOlqjfJxKtx4wM/HEHZ5/t
         LkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z4lDAzcq0tK7uO7uYpar+OsHLEDzVXmQnKo0lZmDk28=;
        fh=iEZ1pAOg1JnIfVRTLQ2WX3nbw9BKpS5XGmfr2oay2a8=;
        b=b8vfDgrznaMTNrE2KhOq+L5ODjnxDiu6u2c7IqJWrfBWiXAbwGUiJSiIY6NSizQrCI
         tJZk6IJ9LT1o+6sB0x0A5t2rRK6bNHNxgFPQw+AI6JOPG60VLa0AvsqAM+RaN2m2YecN
         Ablb4XyKkzHkSwbWdnKqx3X/QCAIhBlsIsNh4Hq1hR3wJViwUuL9NXix040yzDJ/6rnG
         Kn5F2piqCQnIvJYbDRat1fbIKvRQ1IdAZXkXccqFyzugi+cL4D8dwdc8bemhL1q5heuJ
         nDC9oAMh5H1HWJtg/HskKHByJs9IeydEptbF+KfwFSixF9Y1o2jvY25sy+GAZqklTAmP
         gy0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778632068; x=1779236868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4lDAzcq0tK7uO7uYpar+OsHLEDzVXmQnKo0lZmDk28=;
        b=m8tz0/viWh+j2LHKVWyjhtehRP4SgebMoVu9CEyQldq1WFcGNMVXyO3DQBSjkFMBBz
         t2BnKDE14ae2Kkak4Knm3XMhhxGZ4LDM6QozFDgQqpZHYwGJdukoyZNh5jZ0AzpBJBtu
         lW2j3XyJkjxUtMB9SmbRLo9/TQzkTEJ6XK6vh03W+SoaFLVwqTys+7MmtdDmkHDLLn8+
         tm1vFE+fDNCch6Q19OOwn0CgIz0D+5g2KelQ4rs9i2qpVTYtO7+1oidCMBroh8wa810N
         lYURaexs2geOJba+cJRDQdAvPb6KHVCZioopf/uOz/OpskTTG2RJYSrtURaSzte3tXRL
         +wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778632068; x=1779236868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z4lDAzcq0tK7uO7uYpar+OsHLEDzVXmQnKo0lZmDk28=;
        b=oGQnVDZ8cze2rMCkCjtVblRO5+AUzVt78syi52MPUz7qvxSVxRZv8lormFEEjMXNA0
         WPY2C9nl91nH6mWd8BDNg2odkK8eXNA9BNoocrqD0k/i8SRKKYTq8A7HN1yGqB6ZTetM
         SGyihaSxzC+xNLlr0roorPyUjuC0Ap2fpUv+llo8hUj/qQgsDPDz+LZxBbyW8FX4OtX2
         tjjAmJjSxs6wy6AwI74SupMgbfQ5UD1tcHHc+D8kHghZqw3FPwcawvvr6aM09QDgdK/l
         iQcitItJCQjK/3IDmcjRhFS1GCQ5iChZdIoV63lspypBzFjJJHP1IKdpLIx8BI+Q2NvX
         BW1g==
X-Forwarded-Encrypted: i=1; AFNElJ8v0JGD0W3UM8OZrWlK4nY9xLOhf3Tz2QxxzuYQvnU7CQq6nltNZcCvGuIKsS3XC44YoLYuwClXRxSvmTIg1FjC@vger.kernel.org
X-Gm-Message-State: AOJu0YzS0rjhQcp/27cpW/crkaOydu1pe/5hUKfDhIiXRKrVWbUCVbGg
	+5tjhtoLNuQrixdhlylYeHcmUQ+xzCRKYDWl0lL4B20Ejw7AbCdrBsx3OtH3PpkKkQN+dUgsxlZ
	NsYjWRaivtGz3VyuEZ/i35vSWtVHaKLEY0mRQvBAA
X-Gm-Gg: Acq92OGUqrV/8Y0S38KeRIUiR0npwLdEqgKQOTNk7rr5HeSiKvsmRjg5CIkU0B7t1YP
	Okx3fm0jBWJTG918BiVyCyzDGWruQAKXKmsonvm74fZbW+CHOe9t1B6My/7QY3/KiGA2l1YE571
	juNgyjJnXr6Ni182s/JalHhEhw+0fKw7BJUO0CzEyYL59aloBssrMKqfG+8X4zKUYIiKLJQ41VX
	ZO2OKNfkiUIc9FbL3pOg+DNU/79DWipTIiKXE8SwsdiBInqXQMHMujJNAgpbMYO1ZDLhAIpuC3Q
	JBQUpsDjyZD9r3kJmmM=
X-Received: by 2002:a17:903:1b47:b0:2b0:5193:1212 with SMTP id
 d9443c01a7336-2bd266fcccbmr1654775ad.4.1778632067693; Tue, 12 May 2026
 17:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512233048.9577-1-zide.chen@intel.com> <20260512233048.9577-5-zide.chen@intel.com>
In-Reply-To: <20260512233048.9577-5-zide.chen@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 17:27:35 -0700
X-Gm-Features: AVHnY4K5EcYo6sViCzU9-9aud0-A6T7MYiSOWMHKZwy_vvZj4DaDlsjs7ZowxAw
Message-ID: <CAP-5=fWj_aLMM-A6ZKdaMBsc4Aw-PRNeScuwwwvh2AQEhLNWpw@mail.gmail.com>
Subject: Re: [PATCH 4/7] perf/x86/intel/uncore: Factor out box setup code
To: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:39=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> The PCI uncore PMU path already implements a lazy registration model:
> the PMU is registered when the first active box appears and
> unregistered when the last active box is removed.
>
> Factor this registration management into a shared helper, so the same
> code can be reused by the MSR and MMIO paths in later changes.
>
> No functional change intended.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/intel/uncore.c | 39 ++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 8d5170788af2..00ed4e5047ac 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1148,6 +1148,29 @@ uncore_pci_find_dev_pmu(struct pci_dev *pdev, cons=
t struct pci_device_id *ids)
>         return pmu;
>  }
>
> +static int uncore_box_setup(struct intel_uncore_pmu *pmu,
> +                           struct intel_uncore_box *box)
> +{
> +       int dies, ret;
> +
> +       /* die_refcnt tracks online dies, not only functioning boxes. */
> +       dies =3D atomic_inc_return(&pmu->die_refcnt);
> +       uncore_box_init(box);
> +
> +       /* First active box registers the pmu. */
> +       if (dies > 1)
> +               return 0;
> +
> +       ret =3D uncore_pmu_register(pmu);
> +       if (ret)
> +               goto err;
> +
> +       return 0;
> +err:
> +       uncore_box_exit(box);
> +       return ret;
> +}
> +
>  /*
>   * Register the PMU for a PCI device
>   * @pdev: The PCI device.
> @@ -1173,19 +1196,13 @@ static int uncore_pci_pmu_register(struct pci_dev=
 *pdev,
>         box->dieid =3D die;
>         box->pci_dev =3D pdev;
>         box->pmu =3D pmu;
> -       uncore_box_init(box);
>
> -       pmu->boxes[die] =3D box;
> -       if (atomic_inc_return(&pmu->die_refcnt) > 1)
> -               return 0;
> -
> -       /* First active box registers the pmu */
> -       ret =3D uncore_pmu_register(pmu);
> -       if (ret) {
> -               pmu->boxes[die] =3D NULL;
> -               uncore_box_exit(box);
> +       ret =3D uncore_box_setup(pmu, box);
> +       if (!ret)
> +               pmu->boxes[die] =3D box;
> +       else
>                 kfree(box);
> -       }
> +
>         return ret;
>  }
>
> --
> 2.54.0
>
