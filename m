From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: What is 'web--browse' on builtin-help.c ?
Date: Wed, 2 Dec 2015 14:05:22 +0900
Message-ID: <20151202050522.GA12758@sejong>
References: <A0EEEF14-34F9-4D51-BD26-52EA958AD2C2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:55935 "EHLO
	lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbbLBFFZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Dec 2015 00:05:25 -0500
In-Reply-To: <A0EEEF14-34F9-4D51-BD26-52EA958AD2C2@gmail.com>
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Taeung Song <treeze.taeung@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi Taeung,

On Wed, Dec 02, 2015 at 12:46:40PM +0900, Taeung Song wrote:
> Hi, all
>=20
> I=E2=80=99m checking perf-help subcommand and config =E2=80=98help.fo=
rmat=E2=80=99.
> source code for them contain functionality for info and web
> but functionality for info and web didn=E2=80=99t work well. ( there =
isn=E2=80=99t problems about =E2=80=98man=E2=80=99 )
>=20
> So, I=E2=80=99m trying to fix the bugs.
> There is a function =E2=80=98open_html()=E2=80=99 on builtin-help.c a=
s below.
>=20
> 408 static void open_html(const char *path)
> 409 {
> 410         execl_perf_cmd("web--browse", "-c", "help.browser", path,=
 NULL);
> 411 }
>=20
> excel_perf_cmd() function lastly call execvp(=E2=80=9Cperf=E2=80=9D, =
(char **)nargv)
> and then error messages like.
>=20
> perf: 'web--browse' is not a perf-command.
>=20
> Is this leftover from git source code ?

I think so, there's git-web--browse script to find and run available
web browser on a system.

Thanks,
Namhyung
