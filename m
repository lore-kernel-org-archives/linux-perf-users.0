Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF5A17588;
	Thu, 25 Jul 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925538; cv=none; b=tPIxwHyiGy+ECI2rydZ/C3PLIc2B2cvHe2QlMAAUj0WSrvNc9bms0s1ULRJi1RiooAanx74TA3upzCJuniwG1MqyIMLpFVHb6hdLhfRyu/mizMVOBKqMH0lrOO2qc1jfm3LwIEDjWq2sX8w3ok5+dYIfTZoZa1hwlOi1xKmk5Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925538; c=relaxed/simple;
	bh=1R93NxJhFkpwpTA0n6/mhREWx2ZosY7WH0zly8AsrdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0KFjrEqI+kfJy1wPEphGJRYGrJYBAuUbFvo2+k2P4+wQPrCX/8BB7pwnbaFJNxvLIchkp2mRITUohl/NsYAqBnL4x/AZw6GJ4EFd8FlyEraZym4K4qVtyqCasFpm/7oTWC50QoW+y5ymWfHAAlLS1Eyf5FFWVQS3oNQwauyIy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOprRkt/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOprRkt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B775C4AF0C;
	Thu, 25 Jul 2024 16:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721925537;
	bh=1R93NxJhFkpwpTA0n6/mhREWx2ZosY7WH0zly8AsrdQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LOprRkt/FW7G0qurHjLGMwvyAyRcwOZcpYx+KUv3200IdXSEB2NuwBcCIn+zVc6Gv
	 cDo6uN7h7qqtzuXXu2bSZivhDWFlmr8GOrLn8okPBRmUvee8HSDZ2S5IqrHLOylBN5
	 9VqDBRCS5AEFcNclhsJ3qhRUGUtg3e8gqe79nNaQVaxxD771MEbXvaz6Hu9Sg6n6p+
	 gJxcfjBveb7hMZMq8MUUjIw4tkZrvTL8ZHHzubN+QdYLEPEwEjdLNTwSwHmH6uhr2Q
	 zSnCWeY2L4aJ65sGS2Rd2n/1WifKGMdAsi76AoqTi746pX6+WvGlYlTRx6m1fL4IXE
	 ELX7cN4F+ZZGA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f01993090so549072e87.2;
        Thu, 25 Jul 2024 09:38:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5aaknCFqPHoK+Dv9kUO+vNrxOKDuJcQDgaN1lIIecjXdiZqdgd6OcbcgwCxUc0NrlRh2bAqD8hvJPx/trMrOgqzEGNf3BKxiEYL6iygAMQLair/F56ouTIC4LQiDQo3LMeG2m+x3wIlm3sQPkEA==
X-Gm-Message-State: AOJu0YzgS4a2ELZ5VunXv8VWB+2Jo2ye/HRs2zWcwdgj8D5mHXA9BwIw
	x4TrofpyY2G3ymhqnIofSPOar/N+E+Hiy7y/79aPxdOVE7hiYRmoTmZbltoc06K9v07KNpFqLyy
	9krAwLouipbh+QDPXsup7k68Wu6Q=
X-Google-Smtp-Source: AGHT+IG9tcPGYe/OimxP77WlU0vqCo8JnmY2sPztGjJCuiaA0W/xXaSTQJ66a8de6hsq5F9bESTNvnhGEMoPxicI6Zk=
X-Received: by 2002:a05:6512:2393:b0:52e:bdfc:1d09 with SMTP id
 2adb3069b0e04-52fd602b484mr1916962e87.18.1721925535863; Thu, 25 Jul 2024
 09:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com>
 <26fb7054-f877-496f-b23a-9b6a3d752595@linux.intel.com>
In-Reply-To: <26fb7054-f877-496f-b23a-9b6a3d752595@linux.intel.com>
From: Song Liu <song@kernel.org>
Date: Thu, 25 Jul 2024 09:38:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6+7ULMQFLbmOsBzYAdd8LMV54h_ynfkGDxd_oH6O8cww@mail.gmail.com>
Message-ID: <CAPhsuW6+7ULMQFLbmOsBzYAdd8LMV54h_ynfkGDxd_oH6O8cww@mail.gmail.com>
Subject: Re: Some unc_cha_tor_* events appear to be "not supported"?
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	jonesz@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kan,

Thanks for your quick response!

On Thu, Jul 25, 2024 at 6:37=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-07-24 6:39 p.m., Song Liu wrote:
> > Hi folks,
> >
> > We noticed that some unc_cha_tor_occupancy and unc_cha_tor_inserts even=
ts
> > appear to be "not supported" and always counting zero (see an example b=
elow).
> > Is this a known issue? We are testing with 6.10 kernel and perf.
> >
> > Thanks,
> > Song
> >
> >
> > [root@kerneltest008.05.atn6 ~]# ./perf list | grep
> > unc_cha_tor_occupancy.ia_hit_llcprefdrd
> >   unc_cha_tor_occupancy.ia_hit_llcprefdrd
> > [root@kerneltest008.05.atn6 ~]# ./perf stat -e
> > unc_cha_tor_occupancy.ia_hit_llcprefdrd -a -- sleep 1
> > WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
>
>
> The value '4b433' is for the 'Filter1', according to the original event
> list.
>
> https://github.com/intel/perfmon/blob/main/SKX/events/skylakex_uncore.jso=
n#L4634
>
>       "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
>       "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
>       "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
>       "Counter": "0",
>       "MSRValue": "0x00",
>       "ELLC": "0",
>       "Filter": "Filter1",
>       "ExtSel": "0",
>       "Deprecated": "0",
>       "FILTER_VALUE": "0x4b433"
>
> There are two filters for CHA on SKX. Each filter is 32 bits wide.
> So the Linux kernel driver uses config1 (64 bits wide) to represent both
> of them. The low 32 bits are for filter0 and high 32 bits are for filter1=
.
>
> It should be an issue of the convert script, which set the filter1 value
> to the low 32 bits.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json#n4489
>
> Can you please try the below event?
> uncore_cha/event=3D0x35,umask=3D0x11,config1=3D0x4b43300000000/

This appears to work. I also tried events like:

uncore_cha/UNC_CHA_TOR_OCCUPANCY.IA_MISS,config1=3D0x4043200000000/
uncore_cha/UNC_CHA_TOR_INSERTS.IA_MISS,config1=3D0x4043200000000/

Do you have an idea on how to fix the convert script? I haven't looked
into these codes.

Thanks,
Song

[...]
