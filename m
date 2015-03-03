From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: What do mean children of top ?
Date: Tue, 3 Mar 2015 13:23:48 -0300
Message-ID: <20150303162348.GL5187@kernel.org>
References: <FC0BA225-3078-48F1-AC1D-67D6F84D6416@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58358 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655AbbCCQXv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Mar 2015 11:23:51 -0500
Content-Disposition: inline
In-Reply-To: <FC0BA225-3078-48F1-AC1D-67D6F84D6416@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: TaeWoong Song <treeze.taeung@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>

Em Tue, Mar 03, 2015 at 02:04:47AM +0900, TaeWoong Song escreveu:
> Hi, perf users
>=20
> About=20
> The function perf_top_config() on builtin-top.c:
> It depend on whether top.children is =E2=80=99true=E2=80=99 in perfco=
nfig=20
> that whether =E2=80=98symbol_conf.cumulate_callchain=E2=80=99 is =E2=80=
=99true=E2=80=99 or not.
> (when =E2=80=98top' only work with =E2=80=98=E2=80=94call-graph' )
>=20
> The output of =E2=80=99top =E2=80=94call-graph fp=E2=80=99 is changed=
 depending on  a boolean value of =E2=80=98symbol_conf.cumulate_callcha=
in=E2=80=99.
>=20
> Do mean children of top relationship of calling functions which are p=
arents or children ?=20
> Linked-ring of invoking functions ? =20
>=20
> I wanna exactly explain the effect of =E2=80=98top.children=E2=80=99 =
in perfconfig.
> Can anybody tell me the different between true and false on top.child=
ren ?
>=20
> If anybody a bit give hints me, I=E2=80=99ll appreciate it.=20

Namhyung?

- Arnaldo
