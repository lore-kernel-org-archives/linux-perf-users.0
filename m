From: Taeung Song <treeze.taeung@gmail.com>
Subject: What is 'web--browse' on builtin-help.c ?
Date: Wed, 2 Dec 2015 12:46:40 +0900
Message-ID: <A0EEEF14-34F9-4D51-BD26-52EA958AD2C2@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33633 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbbLBDqq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Dec 2015 22:46:46 -0500
Received: by pabfh17 with SMTP id fh17so27452825pab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Dec 2015 19:46:46 -0800 (PST)
Received: from [10.138.13.185] ([211.61.23.220])
        by smtp.gmail.com with ESMTPSA id l20sm801407pfi.10.2015.12.01.19.46.43
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 19:46:45 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi, all

I=E2=80=99m checking perf-help subcommand and config =E2=80=98help.form=
at=E2=80=99.
source code for them contain functionality for info and web
but functionality for info and web didn=E2=80=99t work well. ( there is=
n=E2=80=99t problems about =E2=80=98man=E2=80=99 )

So, I=E2=80=99m trying to fix the bugs.
There is a function =E2=80=98open_html()=E2=80=99 on builtin-help.c as =
below.

408 static void open_html(const char *path)
409 {
410         execl_perf_cmd("web--browse", "-c", "help.browser", path, N=
ULL);
411 }

excel_perf_cmd() function lastly call execvp(=E2=80=9Cperf=E2=80=9D, (c=
har **)nargv)
and then error messages like.

perf: 'web--browse' is not a perf-command.

Is this leftover from git source code ?


Thanks,
Taeung

  --
To unsubscribe from this list: send the line "unsubscribe linux-perf-us=
ers" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
