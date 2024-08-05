Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119D165F1B;
	Mon,  5 Aug 2024 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885300; cv=none; b=u8dnpk3s8m3JMab1aFl3M/qxwwGpSXxVJrEL96JEVXR+XdzH73QQsp2Am88V3ti5hjt3f8mgpQki8fW6BxCof8i5ty71jU0x3a/MC9ZwUIiu7JHa6xtQtvQlUX0lyxRQ7r6Iq1kSbK0P9aKhNa3gstuSZSi34vLDBkrlMb1SGtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885300; c=relaxed/simple;
	bh=lzmvPubrwoUTI9tfpxF4lmiuBZJxw0oA6YEya0VDcZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5v5IbXa9F/HUUxq4AefFqSB8QaZlsmfJgpUtQj5gwLgDA4azTIthhVcEB8YqLY2GJO19uD8ky9jZaKoJjan7LOJgH6yUUfMYN2FhYzd0acift/2uS/CxCPX+UYdKQU+jU2yKsO3cqaRYZb00oVbsEomj5DC9Apc36Lf4p89Xqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJi0ByvH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJi0ByvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BC9C4AF10;
	Mon,  5 Aug 2024 19:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722885300;
	bh=lzmvPubrwoUTI9tfpxF4lmiuBZJxw0oA6YEya0VDcZ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JJi0ByvHgCL1rjHPJQZWr1OI9JOg2cL4Ttim/kOHVVm25zShP6iftoeitdpwcdZDe
	 771ALemLSyk1e483j08zq7nsXT2C5EKLK55l1yy/DKs1FhtInvNXWulSV6l4RY0e1b
	 iNfqcfYIgwtbsoScyV8HSP5RZFFgTNTZ8OwiWMLsVM1GQT/mhr7J0ppeIGqOT+J8O4
	 nUwtq7ZMO6tp8j680AwxuCzgbrvNdXRGrj4V4PppjwcNy237W2HyPTCI4wWWqfNRVQ
	 2c5Tytk3df1jH2XmuEIucWpSSAkAdOc7epclZKSjOTli2e8ed9qf/1cuh6rjiSBHBX
	 cTSHrYEAmIvdQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efbb55d24so16887241e87.1;
        Mon, 05 Aug 2024 12:14:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUylCkA8FiMY9D+XjZpFW2O87GCWW5M2XvVotCRC8zKiCiZQRzPi7cR8t3l67aP3flw5dAwt2js8zRTh/Qrn1spkDxD8yxABLm8hL9tQI1voWJ29b8CW4ApYYXpCP2ynlNFSZu35KKwKAzwS/8xvw==
X-Gm-Message-State: AOJu0YywqyFJRivrjbKHG3j9LAPbty0+J19uv3wDK+9uaXOnRO2NrJVB
	sfOQmWRtvydy2M0E8iLk2n/EPhBu/zI/1x2+QEWkMDe+aHJgHXCWhPDDNXr/91uqyaPiCHFwYe3
	mDU+V8FFw+qvB8mxMVrI9YOituXE=
X-Google-Smtp-Source: AGHT+IGqi3LlNhl70feM/dQAQTw2uwycNXeyhS4UKt3zkjysFVGYhX4LxkR4ebusK9youYhs8qDR/wyf35aFFEbE6U0=
X-Received: by 2002:a05:6512:31c1:b0:52e:716a:1898 with SMTP id
 2adb3069b0e04-530bb3bcc80mr9882552e87.58.1722885298420; Mon, 05 Aug 2024
 12:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com>
 <26fb7054-f877-496f-b23a-9b6a3d752595@linux.intel.com> <CAPhsuW6+7ULMQFLbmOsBzYAdd8LMV54h_ynfkGDxd_oH6O8cww@mail.gmail.com>
 <CAP-5=fVNfGT+a1RG9-ugKWjQR-83vLdHo-6vCVz=N=CBF4_7ug@mail.gmail.com>
 <CO6PR11MB5635E5844F7C8CB1277C1DF4EEAB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAPhsuW6Hq4qno1=K9-q17TsNO7S4-dQMCfo_nAQZ7EMdcuP6NQ@mail.gmail.com> <CO6PR11MB563550B4AB0D89D6DAC39CBAEEBE2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB563550B4AB0D89D6DAC39CBAEEBE2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Song Liu <song@kernel.org>
Date: Mon, 5 Aug 2024 12:14:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW76F2PkpSpB+V039_0orX9aRwj=++XzM7k1omGVZY-uEw@mail.gmail.com>
Message-ID: <CAPhsuW76F2PkpSpB+V039_0orX9aRwj=++XzM7k1omGVZY-uEw@mail.gmail.com>
Subject: Re: Some unc_cha_tor_* events appear to be "not supported"?
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	"Taylor, Perry" <perry.taylor@intel.com>, "Baker, Edward" <edward.baker@intel.com>, 
	"Daneti, Venkata Naga Sai Dilip" <venkata.naga.sai.dilip.daneti@intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"jonesz@meta.com" <jonesz@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Weilin,

On Mon, Aug 5, 2024 at 11:34=E2=80=AFAM Wang, Weilin <weilin.wang@intel.com=
> wrote:
[...]
> > > > > >
> > > > > > The value '4b433' is for the 'Filter1', according to the origin=
al event
> > > > > > list.
> > > > > >
> > > > > >
>
> @Song Liu, do you see different output from some other unc_cha_tor_occupa=
ncy
> and unc_cha_tor_inserts events. Or, are all of them report the same warni=
ng like this
> example here?
>
> Could you please try UNC_CHA_TOR_OCCUPANCY.IA_MISS and share the output?
> Please also specify the platform you tested on. Thanks!

This event is working, I guess. Though the output is zero on the host.

[root@ ~]# perf stat -e  UNC_CHA_TOR_OCCUPANCY.IA_MISS -a -- sleep 1

 Performance counter stats for 'system wide':

                 0      UNC_CHA_TOR_OCCUPANCY.IA_MISS

       1.002497126 seconds time elapsed

For this one, I am testing on Intel(R) Xeon(R) D-2191A CPU @ 1.60GHz.
I think the issue happens on all skylake and copperlake CPUs.

>
> > > >
> > https://github.com/intel/perfmon/blob/main/SKX/events/skylakex_uncore.j=
s
> > > > on#L4634
> > > > > >
> > > > > >       "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> > > > > >       "BriefDescription":
> > > > "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> > > > > >       "PublicDescription":
> > > > "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> > > > > >       "Counter": "0",
> > > > > >       "MSRValue": "0x00",
> > > > > >       "ELLC": "0",
> > > > > >       "Filter": "Filter1",
> > > > > >       "ExtSel": "0",
> > > > > >       "Deprecated": "0",
> > > > > >       "FILTER_VALUE": "0x4b433"
> > > > > >
> > > > > > There are two filters for CHA on SKX. Each filter is 32 bits wi=
de.
> > > > > > So the Linux kernel driver uses config1 (64 bits wide) to repre=
sent both
> > > > > > of them. The low 32 bits are for filter0 and high 32 bits are f=
or filter1.
> > > > > >
> > > > > > It should be an issue of the convert script, which set the filt=
er1 value
> > > > > > to the low 32 bits.
>
> @Liang, Kan, the following is the converted "UNC_CHA_TOR_OCCUPANCY.IA_MIS=
S_LlcPrefDRD"
> in perf JSON. The "Filter" filed has value "config1=3D0x4b433", which loo=
ks correct to
> me according to your description above.
>
> Please let me know your thoughts.
>
>     {
>         "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
>         "Counter": "0",
>         "EventCode": "0x36",
>         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
>         "Filter": "config1=3D0x4b433",
>         "PerPkg": "1",
>         "UMask": "0x21",
>         "Unit": "CHA"
>     },

I think we need config1 to be 0x4b43300000000?

Thanks,
Song
