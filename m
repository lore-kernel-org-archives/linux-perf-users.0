Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C16BFA6;
	Fri,  2 Aug 2024 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635456; cv=none; b=Nf6foKl6LjHiqr0HldqHqYhOJYe6rjOKirzDqYUpFLravaiseaAiKI8tnR4UfZvUiLsZWi0dHIlBQioIBQC3NFuvPCYpbwYK7FINuadQfrMnnxgtyC8jY783gLNM1kglBzQeuDWlBD500dy5oGTezt3RxuVmFc/o0wFFI7tzSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635456; c=relaxed/simple;
	bh=uuXgtuDH8cBQ87gq4/YyxIlFuK+mRg3H1gD0rb9Obd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCX5+VgUPyxajeVccWOGqiAw2DVKRwoykQci51ySKiq2RysHgdDL9eQ+97zWl69b3vQ38WqKXEkxaX/eDR9Ky/lfuR8al4rhliOJxh23FnFMUdFlpjMqdlynUFAB+xxx63dU5/PiexKdy3/8p71zpScx714Qegt8lX0pQF+BqAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYzAF4bP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYzAF4bP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D11C4AF0C;
	Fri,  2 Aug 2024 21:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635456;
	bh=uuXgtuDH8cBQ87gq4/YyxIlFuK+mRg3H1gD0rb9Obd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pYzAF4bPjvUqSInyhmJfqXrjo7GeEOzF4484peaqtRqn932/aRWyIJf1XnHY+VSzw
	 wclnrnb9A/FQu4dKkCM8UPQu133pZft3XvKBhLJhXocimH6b+8WRgnvRbdkOuXBXcY
	 UwJZBSlNU42ql6x8PKwHgo90H0nW9UfHQXHODP4igH974iSja++WLH2ROfOpofj8XO
	 QbN+zXmDHVzE9wuNn9lkliWeo2HNSSMzUlPTns7ejU7PgUqZ9iqs9VK0/1zGCbQXDf
	 JTz7JV+qrKzjT6CEeRA/a87BRJ0WquYcE4sUN/9ipcC46OsR/wzDE+TbBwAex7XUYz
	 YXBasmGxDqUYQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so18747605e87.0;
        Fri, 02 Aug 2024 14:50:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1FRjY+cZt2xWyMwvoMH3xbdPfYyJaDZvmI1uw1DNWILHg3OlZTwjssGZ9bxPh1gzaFTdmWv8dFIKnNXIGXpCbzu+u6QZgApU28a7VmW3achiZCJjq8qC6wSMDHztNBgNYbeGbPgFXY1Wrz+1r7w==
X-Gm-Message-State: AOJu0Yw2bMCbbqVE5j4hBPa/YmoZuU7HHS5sfpHGZ7D4Em9ObJ6rCfdD
	VCb4Y07BpNsk6zjQ2/kF55WUoCCfCV2JTI0inLt+y7vuup03FrqqA9/rPH94+QdFWll2oOb2upm
	Y0HuFJ696YMaAMWptG6Lk23MgcRs=
X-Google-Smtp-Source: AGHT+IGTAK5XT2ims2rToOuqW2RmwAMi6oAavsxippggEd51AEZEmokQvlYaEwA1C3xsfaucgSJZrdBSNfqpYCE0abg=
X-Received: by 2002:a05:6512:308a:b0:52e:9f7a:6e6 with SMTP id
 2adb3069b0e04-530bb3b4602mr4213789e87.41.1722635454577; Fri, 02 Aug 2024
 14:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com>
 <26fb7054-f877-496f-b23a-9b6a3d752595@linux.intel.com> <CAPhsuW6+7ULMQFLbmOsBzYAdd8LMV54h_ynfkGDxd_oH6O8cww@mail.gmail.com>
 <CAP-5=fVNfGT+a1RG9-ugKWjQR-83vLdHo-6vCVz=N=CBF4_7ug@mail.gmail.com> <CO6PR11MB5635E5844F7C8CB1277C1DF4EEAB2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5635E5844F7C8CB1277C1DF4EEAB2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Song Liu <song@kernel.org>
Date: Fri, 2 Aug 2024 14:50:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6Hq4qno1=K9-q17TsNO7S4-dQMCfo_nAQZ7EMdcuP6NQ@mail.gmail.com>
Message-ID: <CAPhsuW6Hq4qno1=K9-q17TsNO7S4-dQMCfo_nAQZ7EMdcuP6NQ@mail.gmail.com>
Subject: Re: Some unc_cha_tor_* events appear to be "not supported"?
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Baker, Edward" <edward.baker@intel.com>, 
	"Daneti, Venkata Naga Sai Dilip" <venkata.naga.sai.dilip.daneti@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"jonesz@meta.com" <jonesz@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

What are the next steps with this issue? I guess we need to update the
scripts and regenerate the JSON files?

Thanks,
Song

On Thu, Jul 25, 2024 at 10:52=E2=80=AFAM Wang, Weilin <weilin.wang@intel.co=
m> wrote:
>
>
>
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Thursday, July 25, 2024 10:00 AM
> > To: Song Liu <song@kernel.org>; Wang, Weilin <weilin.wang@intel.com>;
> > Taylor, Perry <perry.taylor@intel.com>
> > Cc: Liang, Kan <kan.liang@linux.intel.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; linux-perf=
-
> > users@vger.kernel.org; open list <linux-kernel@vger.kernel.org>; Namhyu=
ng
> > Kim <namhyung@kernel.org>; Jiri Olsa <jolsa@kernel.org>; jonesz@meta.co=
m
> > Subject: Re: Some unc_cha_tor_* events appear to be "not supported"?
> >
> > On Thu, Jul 25, 2024 at 9:39=E2=80=AFAM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > Hi Kan,
> > >
> > > Thanks for your quick response!
> > >
> > > On Thu, Jul 25, 2024 at 6:37=E2=80=AFAM Liang, Kan <kan.liang@linux.i=
ntel.com>
> > wrote:
> > > >
> > > >
> > > >
> > > > On 2024-07-24 6:39 p.m., Song Liu wrote:
> > > > > Hi folks,
> > > > >
> > > > > We noticed that some unc_cha_tor_occupancy and unc_cha_tor_insert=
s
> > events
> > > > > appear to be "not supported" and always counting zero (see an exa=
mple
> > below).
> > > > > Is this a known issue? We are testing with 6.10 kernel and perf.
> > > > >
> > > > > Thanks,
> > > > > Song
> > > > >
> > > > >
> > > > > [root@kerneltest008.05.atn6 ~]# ./perf list | grep
> > > > > unc_cha_tor_occupancy.ia_hit_llcprefdrd
> > > > >   unc_cha_tor_occupancy.ia_hit_llcprefdrd
> > > > > [root@kerneltest008.05.atn6 ~]# ./perf stat -e
> > > > > unc_cha_tor_occupancy.ia_hit_llcprefdrd -a -- sleep 1
> > > > > WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b43=
3'
> > > >
> > > >
> > > > The value '4b433' is for the 'Filter1', according to the original e=
vent
> > > > list.
> > > >
> > > >
> > https://github.com/intel/perfmon/blob/main/SKX/events/skylakex_uncore.j=
s
> > on#L4634
> > > >
> > > >       "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> > > >       "BriefDescription":
> > "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> > > >       "PublicDescription":
> > "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> > > >       "Counter": "0",
> > > >       "MSRValue": "0x00",
> > > >       "ELLC": "0",
> > > >       "Filter": "Filter1",
> > > >       "ExtSel": "0",
> > > >       "Deprecated": "0",
> > > >       "FILTER_VALUE": "0x4b433"
> > > >
> > > > There are two filters for CHA on SKX. Each filter is 32 bits wide.
> > > > So the Linux kernel driver uses config1 (64 bits wide) to represent=
 both
> > > > of them. The low 32 bits are for filter0 and high 32 bits are for f=
ilter1.
> > > >
> > > > It should be an issue of the convert script, which set the filter1 =
value
> > > > to the low 32 bits.
> > > >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/
> > perf/pmu-events/arch/x86/skylakex/uncore-cache.json#n4489
> > > >
> > > > Can you please try the below event?
> > > > uncore_cha/event=3D0x35,umask=3D0x11,config1=3D0x4b43300000000/
> > >
> > > This appears to work. I also tried events like:
> > >
> > >
> > uncore_cha/UNC_CHA_TOR_OCCUPANCY.IA_MISS,config1=3D0x40432000000
> > 00/
> > >
> > uncore_cha/UNC_CHA_TOR_INSERTS.IA_MISS,config1=3D0x4043200000000/
> > >
> > > Do you have an idea on how to fix the convert script? I haven't looke=
d
> > > into these codes.
> >
> > The converter script logic is here:
> > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#=
L3
> > 95
> > but presumably this worked at some point or is needed on other models.
> > Checking the perf json I see:
> > ```
> > $ grep -rl config1 tools/perf/pmu-events/arch/x86/
> > tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
> > tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> > tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
> > tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
> > tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > ```
> > Since CLX is near equal to SKX, and the metrics will presumably be
> > false hits, perhaps shifting this value will break snowridgex - I have
> > no such machine to test on.
> >
> > Using config1 values rather than formats is odd to me. On a SkylakeX I =
see:
> > ```
> > $ grep -r config1 /sys/devices/uncore_cha_0/format/
> > /sys/devices/uncore_cha_0/format/filter_rem:config1:32
> > /sys/devices/uncore_cha_0/format/filter_opc0:config1:41-50
> > /sys/devices/uncore_cha_0/format/filter_isoc:config1:63
> > /sys/devices/uncore_cha_0/format/filter_tid:config1:0-8
> > /sys/devices/uncore_cha_0/format/filter_loc:config1:33
> > /sys/devices/uncore_cha_0/format/filter_nc:config1:62
> > /sys/devices/uncore_cha_0/format/filter_opc1:config1:51-60
> > /sys/devices/uncore_cha_0/format/filter_all_op:config1:35
> > /sys/devices/uncore_cha_0/format/filter_not_nm:config1:37
> > /sys/devices/uncore_cha_0/format/filter_state:config1:17-26
> > /sys/devices/uncore_cha_0/format/filter_nm:config1:36
> > ```
> >
> > Adding Weilin and Perry as I'm unsure what the right fix should be. My
> > thought is the input Intel perfmon json should break apart the filter
> > value into opcodes, etc. and then in the converter script we add these
> > to perf events like filter_opc0=3D0xb4.
> >
>
> Adding Ed and Dilip for event related questions. I can follow up to updat=
e the
> converter script once we are clear about the content we need/could provid=
e
> in event JSON.
>
> Thanks,
> Weilin
>
> > Thanks,
> > Ian
> >
> > > Thanks,
> > > Song
> > >
> > > [...]
