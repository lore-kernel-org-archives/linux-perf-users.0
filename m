From: TaeWoong Song <treeze.taeung@gmail.com>
Subject: several questions about config
Date: Sun, 15 Feb 2015 20:23:14 +0900
Message-ID: <039ADDFB-D656-4760-842A-F65B780198C3@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:37537 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbbBOLXQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 15 Feb 2015 06:23:16 -0500
Received: by mail-pa0-f43.google.com with SMTP id fa1so28917069pad.2
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Feb 2015 03:23:15 -0800 (PST)
Received: from [10.138.13.172] ([211.61.23.220])
        by mx.google.com with ESMTPSA id yl2sm11671275pbb.1.2015.02.15.03.23.13
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 15 Feb 2015 03:23:14 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi, perf users and developers=20

I have several questions about perfconfig

1. [colors] section : What is concrete evaluation standard of =E2=80=99=
top=E2=80=99 and =E2=80=98medium=E2=80=99 ?
( I've thought  that =E2=80=99top=E2=80=99 and =E2=80=98medium=E2=80=99=
 is decided by CPU overhead(%) but I don=E2=80=99t know it=E2=80=99s mo=
re concrete standard  )

2. [colors] section : Why is it that the name which decide colors of li=
ne for jumping with assemble command such as =E2=80=98jmpq=E2=80=99 is =
=E2=80=98code =E2=80=98 ? =20

3. [colors] section : What would you think  =E2=80=98headers=E2=80=99 i=
s better than =E2=80=98root=E2=80=99 ?
(Because =E2=80=99show-headers=E2=80=99 which [ui] section has decide w=
hether column names on the top of output is shown or not.)

4. [call-graph] section : Is it a bug that after 'sort-key=E2=80=99 is =
set =E2=80=98address=E2=80=99 if I select shared object and  symbol suc=
h as =E2=80=9C [kernel] , [k] vfs_read =E2=80=9C
, perf process is stopped with error message =E2=80=98addr2line: /proc/=
kcore: File format not recognized=E2=80=99 ?=20


Thanks,=20
Taeung=20
