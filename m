From: Joel Fernandes <agnel.joel@gmail.com>
Subject: Re: [RFC] perf: probe_finder: continue if atleast one probe point found
Date: Tue, 1 Mar 2016 02:36:38 -0800
Message-ID: <CAD=GYpZg=zAHBLpfCaDhNVbhXxmdqar6pETrnvBaOYRrGHSB4Q@mail.gmail.com>
References: <1456658087-4107-1-git-send-email-agnel.joel@gmail.com>
	<56D2DB9B.4090500@gmail.com>
	<CAD=GYpZtDb3ugJRFQg1karJ_Fb7RsGPpSu0ZbL8i9Oy8x5eZ9A@mail.gmail.com>
	<20160229141944.GF8720@kernel.org>
	<50399556C9727B4D88A595C8584AAB37B4E274CB@GSjpTKYDCembx32.service.hitachi.net>
	<50399556C9727B4D88A595C8584AAB37B4E27589@GSjpTKYDCembx32.service.hitachi.net>
	<CAD=GYpbSh_mu3skV+8nVaObQuJKYgcmBXFmEDWL24kb_tk6ZXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38379 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbcCAKgj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Mar 2016 05:36:39 -0500
In-Reply-To: <CAD=GYpbSh_mu3skV+8nVaObQuJKYgcmBXFmEDWL24kb_tk6ZXw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?UTF-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>
Cc: "ltc-kernel@ml.yrl.intra.hitachi.co.jp" <ltc-kernel@ml.yrl.intra.hitachi.co.jp>, Arnaldo Carvalho de Melo <acme@kernel.org>, Taeung Song <treeze.taeung@gmail.com>, Joel Fernandes <joel.opensrc@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, sysp-manager <cti.systems-productivity-manager.ts@hitachi.com>

Sorry about the line wrapping, I sent this email through g-mail.
Shouldn't have any issue when I send the final patch through git
send-email.

Thanks,
Joel

On Tue, Mar 1, 2016 at 2:34 AM, Joel Fernandes <agnel.joel@gmail.com> w=
rote:
> Hi Hiramatu,
>
> On Mon, Feb 29, 2016 at 8:29 PM, =E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3=
 / HIRAMATU=EF=BC=8CMASAMI
> <masami.hiramatsu.pt@hitachi.com> wrote:
>> BTW,
>>
>> ./perf probe  \
>>   -k ./vmlinux -s ./ -x /lib/x86_64-linux-gnu/libc.so.6 -a 'malloc $=
params'
>>
>> might help your case. $params is expanded to function parameters aut=
omatically
>> and if there is no parameters, it is just ignored :)
>
> Thanks, I agree this is a better approach.
>
> How about an informative error letting the user know about it? Is the
> below Ok? I can send a patch.
>
> ----x8--------
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-f=
inder.c
> index 4ce5c5e..21f282a 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1247,8 +1247,12 @@ static int add_probe_trace_event(Dwarf_Die
> *sc_die, struct probe_finder *pf)
>                 pf->tvar =3D &tev->args[i];
>                 /* Variable should be found from scope DIE */
>                 ret =3D find_variable(sc_die, pf);
> -               if (ret !=3D 0)
> +               if (ret !=3D 0) {
> +                       pr_err("Variable couldn't be found, if probe
> is on inline function,"
> +                              "try '%s' or '%s' instead.\n",
> +                              PROBE_ARG_PARAMS, PROBE_ARG_VARS);
>                         break;
> +               }
>         }
