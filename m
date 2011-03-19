From: stephane eranian <eranian@googlemail.com>
Subject: Re: [perfmon2] How does take use of EventName and UnitMask?
Date: Sat, 19 Mar 2011 16:04:47 +0100
Message-ID: <AANLkTi=qu4np1As7cmN_9EVLe_zWkzFM3uaOt1hDparZ@mail.gmail.com>
References: <tencent_5D9EFCFD67548CB92638B8BA@qq.com>
	<AANLkTinjmVwtWpAnGPyehn0kT6U3KQWKPU0iz=Fb45aA@mail.gmail.com>
	<AANLkTi=e_gB-hLqxf4Cyoh9u+Cb4pdxpfGJZrZd2gKf=@mail.gmail.com>
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63838 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab1CSPEt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 19 Mar 2011 11:04:49 -0400
Received: by wwa36 with SMTP id 36so5904718wwa.1
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Mar 2011 08:04:48 -0700 (PDT)
In-Reply-To: <AANLkTi=e_gB-hLqxf4Cyoh9u+Cb4pdxpfGJZrZd2gKf=@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <arun@sharma-home.net>
Cc: Easley <ugiwgh@gmail.com>, linux-perf-users@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, chenwj <chenwj@iis.sinica.edu.tw>, perfmon2-devel <perfmon2-devel@lists.sourceforge.net>

Arun,

I have pushed a patch that enables uncore support in libpfm4.
This is based on Lin's patch. It takes care of the priv level issue.


On Thu, Mar 17, 2011 at 10:03 PM, Arun Sharma <arun@sharma-home.net> wr=
ote:
> On Thu, Mar 17, 2011 at 8:43 AM, Arun Sharma <arun@sharma-home.net> w=
rote:
>>
>> Stephane has disabled the uncore event support in libpfm4 (since the
>> patch is still not upstream yet). But by uncommenting 2-3 lines of
>> code, you should be able to get uncore events working.
>>
>
> This is the patch I'm using for uncore events with perf + libpfm4.
>
> diff --git a/include/perfmon/perf_event.h b/include/perfmon/perf_even=
t.h
> index 4ba6738..ef68265 100644
> --- a/include/perfmon/perf_event.h
> +++ b/include/perfmon/perf_event.h
> @@ -46,6 +46,7 @@ enum perf_type_id {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0PERF_TYPE_HW_CACHE =C2=A0 =C2=A0 =C2=A0=3D=
 3,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0PERF_TYPE_RAW =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D 4,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0PERF_TYPE_BREAKPOINT =C2=A0 =C2=A0=3D 5,
> + =C2=A0 =C2=A0 =C2=A0 PERF_TYPE_UNCORE =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 6,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0PERF_TYPE_MAX
> =C2=A0};
>
> diff --git a/lib/pfmlib_intel_x86_perf_event.c
> b/lib/pfmlib_intel_x86_perf_event.c
> index ab282dd..b35dccd 100644
> --- a/lib/pfmlib_intel_x86_perf_event.c
> +++ b/lib/pfmlib_intel_x86_perf_event.c
> @@ -81,10 +81,7 @@ pfm_intel_nhm_unc_get_perf_encoding(void *this,
> pfmlib_event_desc_t *e)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D PFM_SUCCESS)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>
> -#if 0
> - =C2=A0 =C2=A0 =C2=A0 /* XXX: uncomment when uncore support is upstr=
eam */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0attr->type =3D PERF_TYPE_UNCORE;
> -#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0attr->config =3D e->codes[0];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * uncore measures at all priv levels
> diff --git a/lib/pfmlib_perf_event.c b/lib/pfmlib_perf_event.c
> index 824f9a5..d2eea5e 100644
> --- a/lib/pfmlib_perf_event.c
> +++ b/lib/pfmlib_perf_event.c
> @@ -157,7 +157,7 @@ pfmlib_perf_event_encode(void *this, const char
> *str, int dfl_plm, void *data)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0attr->exclude_user =3D !(plm & PFM_PLM3);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0attr->exclude_kernel =3D !(plm & PFM_PLM0)=
;
> - =C2=A0 =C2=A0 =C2=A0 attr->exclude_hv =3D !(plm & PFM_PLMH);
> + =C2=A0 =C2=A0 =C2=A0 //attr->exclude_hv =3D !(plm & PFM_PLMH);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__pfm_vbprintf("PERF[type=3D%x config=3D0x=
%"PRIx64" config1=3D0x%"PRIx64
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0" e_u=3D%d e_k=3D%d e_hv=3D%d period=3D%"PRIu64" freq=3D%=
d"
>
> =C2=A0-Arun
>
> ---------------------------------------------------------------------=
---------
> Colocation vs. Managed Hosting
> A question and answer guide to determining the best fit
> for your organization - today and in the future.
> http://p.sf.net/sfu/internap-sfd2d
> _______________________________________________
> perfmon2-devel mailing list
> perfmon2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/perfmon2-devel
>
