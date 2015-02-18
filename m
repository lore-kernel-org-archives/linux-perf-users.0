From: TaeWoong Song <treeze.taeung@gmail.com>
Subject: perf config : Have not effect pager.cmd  ?
Date: Wed, 18 Feb 2015 19:32:46 +0900
Message-ID: <C83B54E2-ECD1-45F9-B5BC-4DB934F8062A@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35367 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbbBRKcr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Feb 2015 05:32:47 -0500
Received: by pdbfl12 with SMTP id fl12so287555pdb.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Feb 2015 02:32:47 -0800 (PST)
Received: from [192.168.0.2] ([220.86.35.214])
        by mx.google.com with ESMTPSA id ck11sm20510934pac.5.2015.02.18.02.32.43
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Feb 2015 02:32:46 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi, list=20

Haven=E2=80=99t effect pager.cmd ?=20

I expected all output of command =E2=80=98perf annotate =E2=80=94stdio=E2=
=80=99 was printed when I set pager.cmd =E2=80=99false=E2=80=99.
But whether  pager.cmd is =E2=80=99true=E2=80=99 or not =E2=80=98perf a=
nnotate =E2=80=94stdio=E2=80=99 works with pager or less.  =20

If not, was it misused ?=20
Is for other command pager.cmd ?=20


Thanks,
Taeung
