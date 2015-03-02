From: TaeWoong Song <treeze.taeung@gmail.com>
Subject: What do mean children of top ?
Date: Tue, 3 Mar 2015 02:04:47 +0900
Message-ID: <FC0BA225-3078-48F1-AC1D-67D6F84D6416@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36557 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbbCBREy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 2 Mar 2015 12:04:54 -0500
Received: by pdbnh10 with SMTP id nh10so17354208pdb.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Mar 2015 09:04:53 -0800 (PST)
Received: from [211.201.152.53] ([211.201.152.53])
        by mx.google.com with ESMTPSA id ym10sm11412998pac.10.2015.03.02.09.04.51
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Mar 2015 09:04:52 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi, perf users

About=20
The function perf_top_config() on builtin-top.c:
It depend on whether top.children is =E2=80=99true=E2=80=99 in perfconf=
ig=20
that whether =E2=80=98symbol_conf.cumulate_callchain=E2=80=99 is =E2=80=
=99true=E2=80=99 or not.
(when =E2=80=98top' only work with =E2=80=98=E2=80=94call-graph' )

The output of =E2=80=99top =E2=80=94call-graph fp=E2=80=99 is changed d=
epending on  a boolean value of =E2=80=98symbol_conf.cumulate_callchain=
=E2=80=99.

Do mean children of top relationship of calling functions which are par=
ents or children ?=20
Linked-ring of invoking functions ? =20

I wanna exactly explain the effect of =E2=80=98top.children=E2=80=99 in=
 perfconfig.
Can anybody tell me the different between true and false on top.childre=
n ?

If anybody a bit give hints me, I=E2=80=99ll appreciate it.=20


Thanks,
Taeung--
To unsubscribe from this list: send the line "unsubscribe linux-perf-us=
ers" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
