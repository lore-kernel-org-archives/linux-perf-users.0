From: Taeung Song <treeze.taeung@gmail.com>
Subject: Re: What is 'web--browse' on builtin-help.c ?
Date: Wed, 2 Dec 2015 14:37:17 +0900
Message-ID: <C7CB6758-E015-49CD-8508-C338EAFE0A3A@gmail.com>
References: <A0EEEF14-34F9-4D51-BD26-52EA958AD2C2@gmail.com> <20151202050522.GA12758@sejong>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34875 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbbLBFhW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Dec 2015 00:37:22 -0500
Received: by pacej9 with SMTP id ej9so29567046pac.2
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Dec 2015 21:37:22 -0800 (PST)
In-Reply-To: <20151202050522.GA12758@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org

Hi, Namhyung

> On Dec 2, 2015, at 2:05 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Hi Taeung,
>=20
> On Wed, Dec 02, 2015 at 12:46:40PM +0900, Taeung Song wrote:
>> Hi, all
>>=20
>> I=E2=80=99m checking perf-help subcommand and config =E2=80=98help.f=
ormat=E2=80=99.
>> source code for them contain functionality for info and web
>> but functionality for info and web didn=E2=80=99t work well. ( there=
 isn=E2=80=99t problems about =E2=80=98man=E2=80=99 )
>>=20
>> So, I=E2=80=99m trying to fix the bugs.
>> There is a function =E2=80=98open_html()=E2=80=99 on builtin-help.c =
as below.
>>=20
>> 408 static void open_html(const char *path)
>> 409 {
>> 410         execl_perf_cmd("web--browse", "-c", "help.browser", path=
, NULL);
>> 411 }
>>=20
>> excel_perf_cmd() function lastly call execvp(=E2=80=9Cperf=E2=80=9D,=
 (char **)nargv)
>> and then error messages like.
>>=20
>> perf: 'web--browse' is not a perf-command.
>>=20
>> Is this leftover from git source code ?
>=20
> I think so, there's git-web--browse script to find and run available
> web browser on a system.
>=20

Hum.. I thought why don=E2=80=99t use =E2=80=99sensible-browser=E2=80=99=
 command
to launch default browser.
But considering various linux distribution is needed
because some system mightn=E2=80=99t have sensible-browser command.
(I thought we can use this script.)

Thank you for answer anyway.

Thanks,
Taeung
