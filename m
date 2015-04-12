From: Taewoong Song <treeze.taeung@gmail.com>
Subject: Re: [PATCH 2/2] perf tools: Add a option 'remove' to perf-config and features which get or set a config variable.
Date: Sun, 12 Apr 2015 23:45:30 +0900
Message-ID: <44902470-673C-4FFA-9724-1C1B48640775@gmail.com>
References: <1428589591-22838-1-git-send-email-treeze.taeung@gmail.com> <1428589591-22838-2-git-send-email-treeze.taeung@gmail.com> <20150410093136.GB31326@krava.brq.redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36268 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbDLOpf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 12 Apr 2015 10:45:35 -0400
In-Reply-To: <20150410093136.GB31326@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, namhyung@kernel.org, linux-perf-users@vger.kernel.org

Hi, jirka

> On Apr 10, 2015, at 6:31 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Apr 09, 2015 at 11:26:31PM +0900, Taeung Song wrote:
>> This patch consists of adding functions
>> which get, set or remove a specific config variable.
>> For the syntax examples,
>>=20
>>    perf config [options] [section.subkey[=3Dvalue]]
>>=20
>>    display all perf config with default values
>>    # perf config
>>    or
>>    # perf config -a | --all
>=20
> so this is ^^^ what the previous patch does right?
>=20
>>=20
>>    display a specific key(section.subkey) and value
>>    # perf config report.queue
>>=20
>>    set a specific key and value
>>    # perf config report.queue=3D100M
>>=20
>>    remove a specific key
>>    # perf config -r | --remove report.queue
>=20
> haven't checked the code but:
>=20
>  [jolsa@krava perf]$ ./perf config krava=3Dtrue
>  The config variable does not contain a section: krava=3Dtrue[jolsa@k=
rava perf]$=20
>=20
> missing '\n'
>=20
> we can set anything now:
>  [jolsa@krava perf]$ ./perf config krava.krava=3Dtrue
>=20
> the restriction for only known keys would need similar stuff like
> for the '-a' option I asked in the previous email right?
>=20

Thanks for your review.
I sent a couple of patch again.

1. I modified a commit message of second patch to remove comment about =
=E2=80=98-a=E2=80=99, =E2=80=98=E2=80=94all=E2=80=99 option.
2. I added =E2=80=98\n=E2=80=99 character when printing some error mess=
ages.
3. I added =E2=80=98Error: Unknown argument=E2=80=99 message.

But I thought that displaying current config with all possible keys and=
 their default values,
and the restriction for only known keys depending on information of all=
 perf configuration
can be included in next patch.=20
Would you mind ?

Thanks,
Taeung--
To unsubscribe from this list: send the line "unsubscribe linux-perf-us=
ers" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
