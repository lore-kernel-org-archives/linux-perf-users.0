Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA91D63FB
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jan 2025 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737692076; cv=none; b=V4dWFyMvK4EWVWPRU22Uuk1SNAJtSDL/ud8W3UUsv5JbC1xS/hOA8Mi3MXHcbSO252cqF7SrB64X2+zJAKOq6DfcYR0p5uBEhO2BdcF43qvtioRKecH3KViAhyyBkrX0afQ1EZ4aUn3EN4YS+gV98g3L21CfTGO2LxWRm5x5gKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737692076; c=relaxed/simple;
	bh=Q9K8NNu2RAWCel/2x0hxVkgNCK8hIhNlQdfYenrfLwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkHZS+pwGxPAL91JR9Zrj6ni8jQGgrNdpfwIcPxeLBL3y7cZEmu6IjQaYyIK6GJ4GEGZmTXWtYgD4SuHpwjPH0nXD+J3g+YAHZo1z87mN697vtJjOnLeVJxfKAf1wcv70rF/6ojYyIEuyJ1Oq7RMJOhk09ysu4Cw8W4Z3DPZvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfvCV1Db; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfvCV1Db"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so65535ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 20:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737692073; x=1738296873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BBJlY+dd7Vjignx+oxblpwdbhdbID+alwpFAP9eGRM=;
        b=wfvCV1DbN1nvro7nW9aaqtu7fXgLuz5dZDqzw0N8uNFb1WQxTzMzaMazHVmUQPiRp0
         0F1/J3rlB8Vr7qmoj/XFfqNxi55d6B97TIXcDi9DYk5mcrwWG/vKvuFynYwLV6gJZrwj
         omBG56/iwon358qU8p4ACzdLk9KLXf57AKfa5RXbbL7Tp5ehRPHErOs5XRf96KgnzHqe
         O/f2eTkfz6wA+VellZTB9VZ5fOJL11sRM73OFX/D7Zr3E9m1zX3Dln0Zna+HsuCL7ZiI
         ddvojs+qbVNbIzEv7w2vx3Zx40U1JZ6uW2Fz4beJBpAt60jFA4mN+UeGTh1xty0BFRL8
         hdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737692073; x=1738296873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BBJlY+dd7Vjignx+oxblpwdbhdbID+alwpFAP9eGRM=;
        b=Qs7A7kjeFl2Jny1BoL7e7wnDG0WQ1OT5i6NtWI2qttnXCY6TQOmea1cJjTDHb6NPVO
         UPRHyRErNQKxgfqg5gV/9xRpjQT5+BhyougovFCSIYT10jWJap/yrxt05CuM/QnUia3o
         +fuUqWLShVsYQHBrtJ0c1uT0LobFYRfaWHOlht+M2nVUlegki5F+7bDKsHoNFb5tKkJj
         tg+noKcgCIEvJDYzzVYHl4igsx611ydt+N/14UCEW9SndprJpzq91I0xK2uuKn0sVqPv
         4eRJk5i4KRUS3NwrJVDfNDv9fUaSfmRiqx7yX4kyAyExiZdXmfwFg4/pfJOVu70ubm9H
         CrRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ+UKPr3u/thVhbTAOgb52e49Qo5Swg58U5HD7WrffzPenkQ4IafQUkobohJy8BrP25CzYhzhACKRUKfwL6iv8@vger.kernel.org
X-Gm-Message-State: AOJu0YyZoxj+DhuVdn5ukIYjWCMAItZh8ZIGdhq0xDVwlUdFNqmrw+gI
	D6oZ28jSnPydnqH1WJLmVGJdkOy9sLKGEnCXCZzzGm8gPJzPh+5kLNN7gm9OWLOoVi3TEQRAhSr
	m88rPNSut67p4nN7o8Aaa0ylavTT3hBybuRWc
X-Gm-Gg: ASbGncvo2kwCDwvAhqFc0quCuIfrmVGtmzIuoDrLSWPfzgrNOM+OghtkFEiMfhIXwom
	a3NO1XOdV02phfygZJ4Uk8W8gJErjBN+LGccd62H1Raz52kKCh1QQyxFoOSxP9hg=
X-Google-Smtp-Source: AGHT+IGR/nuY3I/CA9IMPeTYW1iZ8iqhjFa/vLyR6ErKhrOj3QqviGdA5YzS2VvZT7xKiAb7Io/a+Yo/8ytbAqV1qo8=
X-Received: by 2002:a05:6e02:ca6:b0:3cf:c98a:ceba with SMTP id
 e9e14a558f8ab-3cfc98aded5mr752935ab.22.1737692073429; Thu, 23 Jan 2025
 20:14:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124035507.52827-1-hanchunchao@inspur.com>
In-Reply-To: <20250124035507.52827-1-hanchunchao@inspur.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Jan 2025 20:14:22 -0800
X-Gm-Features: AWEUYZkmnDVS1ek-sriLtn4Xx_I3g1Pmwush5E47MlBiCkfQbQ6kn7-NNM3YdnM
Message-ID: <CAP-5=fXY8a1yv7DpYPcZ+TeO+_sxv0MNyh3RVMav2JEGyiCn1w@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events: Fix double word in BriefDescription
To: Charles Han <hanchunchao@inspur.com>, Edward <edward.baker@intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 7:55=E2=80=AFPM Charles Han <hanchunchao@inspur.com=
> wrote:
>
> Remove the repeated word "for" in BriefDescription.
>
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Hi,

Thanks for the contribution and reporting the issue! These files are
generated by the script here:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
In the input json files I see the same error:
https://github.com/intel/perfmon/blob/main/GNR/events/graniterapids_uncore_=
experimental.json#L7524
Ed could you address this or should Charles send a fix to github?

Thanks,
Ian

> ---
>  .../graniterapids/uncore-interconnect.json    | 36 +++++++++----------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-intercon=
nect.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnec=
t.json
> index 856ee985ecd4..0f5332ad0b80 100644
> --- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.js=
on
> +++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.js=
on
> @@ -1016,7 +1016,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress bypasses for for AD_BNC",
> +        "BriefDescription": "Egress bypasses for AD_BNC",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1E",
>          "EventName": "UNC_MDF_TxR_BYPASS.AD_BNC",
> @@ -1026,7 +1026,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress bypasses for for AD_CRD",
> +        "BriefDescription": "Egress bypasses for AD_CRD",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1E",
>          "EventName": "UNC_MDF_TxR_BYPASS.AD_CRD",
> @@ -1036,7 +1036,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress bypasses for for AK",
> +        "BriefDescription": "Egress bypasses for AK",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1E",
>          "EventName": "UNC_MDF_TxR_BYPASS.AK",
> @@ -1046,7 +1046,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress bypasses for for BL_BNC",
> +        "BriefDescription": "Egress bypasses for BL_BNC",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1E",
>          "EventName": "UNC_MDF_TxR_BYPASS.BL_BNC",
> @@ -1056,7 +1056,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress bypasses for for BL_CRD",
> +        "BriefDescription": "Egress bypasses for BL_CRD",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1E",
>          "EventName": "UNC_MDF_TxR_BYPASS.BL_CRD",
> @@ -1066,7 +1066,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress bypasses for for IV",
> +        "BriefDescription": "Egress bypasses for IV",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1E",
>          "EventName": "UNC_MDF_TxR_BYPASS.IV",
> @@ -1076,7 +1076,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Number of egress inserts for for AD_BNC",
> +        "BriefDescription": "Number of egress inserts for AD_BNC",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1C",
>          "EventName": "UNC_MDF_TxR_INSERTS.AD_BNC",
> @@ -1086,7 +1086,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Number of egress inserts for for AD_CRD",
> +        "BriefDescription": "Number of egress inserts for AD_CRD",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1C",
>          "EventName": "UNC_MDF_TxR_INSERTS.AD_CRD",
> @@ -1096,7 +1096,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Number of egress inserts for for AK",
> +        "BriefDescription": "Number of egress inserts for AK",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1C",
>          "EventName": "UNC_MDF_TxR_INSERTS.AK",
> @@ -1106,7 +1106,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Number of egress inserts for for BL_BNC",
> +        "BriefDescription": "Number of egress inserts for BL_BNC",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1C",
>          "EventName": "UNC_MDF_TxR_INSERTS.BL_BNC",
> @@ -1116,7 +1116,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Number of egress inserts for for BL_CRD",
> +        "BriefDescription": "Number of egress inserts for BL_CRD",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1C",
>          "EventName": "UNC_MDF_TxR_INSERTS.BL_CRD",
> @@ -1126,7 +1126,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Number of egress inserts for for IV",
> +        "BriefDescription": "Number of egress inserts for IV",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1C",
>          "EventName": "UNC_MDF_TxR_INSERTS.IV",
> @@ -1136,7 +1136,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress occupancy for for AD_BNC",
> +        "BriefDescription": "Egress occupancy for AD_BNC",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1D",
>          "EventName": "UNC_MDF_TxR_OCCUPANCY.AD_BNC",
> @@ -1146,7 +1146,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress occupancy for for AD_CRD",
> +        "BriefDescription": "Egress occupancy for AD_CRD",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1D",
>          "EventName": "UNC_MDF_TxR_OCCUPANCY.AD_CRD",
> @@ -1156,7 +1156,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress occupancy for for AK",
> +        "BriefDescription": "Egress occupancy for AK",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1D",
>          "EventName": "UNC_MDF_TxR_OCCUPANCY.AK",
> @@ -1166,7 +1166,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress occupancy for for BL_BNC",
> +        "BriefDescription": "Egress occupancy for BL_BNC",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1D",
>          "EventName": "UNC_MDF_TxR_OCCUPANCY.BL_BNC",
> @@ -1176,7 +1176,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress occupancy for for BL_CRD",
> +        "BriefDescription": "Egress occupancy for BL_CRD",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1D",
>          "EventName": "UNC_MDF_TxR_OCCUPANCY.BL_CRD",
> @@ -1186,7 +1186,7 @@
>          "Unit": "MDF"
>      },
>      {
> -        "BriefDescription": "Egress occupancy for for IV",
> +        "BriefDescription": "Egress occupancy for IV",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x1D",
>          "EventName": "UNC_MDF_TxR_OCCUPANCY.IV",
> --
> 2.31.1
>
