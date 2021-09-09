Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BF8C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 16:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7CF61100
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 16:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbhIIQxs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 12:53:48 -0400
Received: from sonic315-54.consmr.mail.gq1.yahoo.com ([98.137.65.30]:38479
        "EHLO sonic315-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236918AbhIIQxs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 12:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1631206358; bh=w6am0YTX4LjQs02fccvUWvEzwMflQN4w2b6r3isVzhY=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=RYOkmD1d/s6XepUNSG6CHdgQiljwADstdE02fdqR3cJItPfnXxqsUIjD7gUY5IG/LPU4KtmNhrwhXHZu8S5aD2KfPV1M1JAQyYz/4oBum6/SPHuy92lAJMfrKxZ3+Q8UGRicw3eqRL2kVlib5psWC7dUHj9FTa40j23i3bsC7YCCo8T9IrycQOCXX8zrikpvtRVhdyI4Y83mbUkNUZzrUHKXYGYZasG++S49E39q2DeI/YlGBjpB0tTYQ5dsX7+TTcGRjbGUT5VNxaJ1aSsPndSfUmUdGuEBJ24MOxqM/vyfum//U43RJBpugmVKCZNU4b3KuBVlwsqr8kxQw6J4Qw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631206358; bh=o6WEezQ1Ng6dXCSb4hbMGnr3BNGntkjakFCF9BWslOU=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=PLUUGOoAyUqzzyCgcROPYkY+JRoj+WuDs0zDWAAdvatq18tpBNKqiayHJxGXGed+8lYwOhe6PvLYTGgEXwk1h3rO6AbkwVWET7ZGMdoZ9hoNYbryTDAFzPlW99hevz02JXkDaNp9e4o/wkORs9KiBcobxE5a6tNOApakiuQ+z3hUuUk4koP0eApdLskFe4li9mkeKN8i4+JCRA3gn1N9eF0Ers9twKGlSTHvkrWoxHL02CyBx6CyZtvwWuatyh8vMhzkzMZnM+ueJQsQQW0QlGUukqNNobm4OEC4U2rWHBh3/hjrCs/L7v776E4pbEUwKVHgBpc4ZnrNcYCcUxp/bQ==
X-YMail-OSG: ZfBOQd0VM1mqAQbbeMdoPYZ_nEFwtADzgnsZFiO9WE54weudrFnl1wRxzUZSXCT
 OtIFGqr_u_cX7XxN_vxVD3CB_LcCJRD7q7ogyO1oZleEL3oZz9LCCblzSXa4SdBZetgcYdAyRdFY
 xDMXwBJbkwBd2GG5lnJqjJd8f5gDqpWI.RgXT3RyhPFvG9CRT_RUndchCdpEdJGZCjKClqGkpfg6
 XGmh3vGhafbfFS7yG9TIn_uh3YY6nwhfMYVbC5bpL00.tNgth8FXrZ323Wzmu5XtogqnXUESLKEH
 uTocNZqtkDsDp_yXpU1NjId1pRan3VBUrkEOyfmjRT.ruxb.p2ZCfaQSB26dyCwRK6YfBstP4Fkp
 JFl_4jz4mL5Pbn5BbFKKhreFTx6Z7CtTbEF2evvayD9dYrkww4LDIsY5Y8DsYygM_jCYKo_CM8Da
 zoiPJdhkJ7sBlDOleGCrcSFfTyBK9x5Y0hhpJW1QHasP.m.5YB_9DGmCG3fKOmeCvd9tKRhE7uEp
 RT.dymLT46RTyUJytvIeR1ysYZQDtEayto8pVpsv2IOlWfE_zhQWmlv0CWFyyvyZrcLEcizqzsdq
 N0R84CT8IFVnn4r1PWVqm46OsY199t5eWNN.1vv14jpJ3oHMXjw0xDoJZIrY1lrd0COHl55gQcJL
 rMke83U9XaV9TmqfRpvYeN8hcvG14qyBKPzxv44dfM496_.sdLJEMj.0HFrWXDcR_6HJTJGkdEon
 pEfjYrvoeF3wOWEwC5dBSvb6yYpHgOCI2Sn7O32qOvExwDgCkZeEEd8dUCr8cwf5UjWUp6Vg_.Vj
 dF6p6OPIgsoWwUuV_IwoyUwZRAjAjiuqvqCn_wobLr8IiuJdhlyK496.t6O_4wV0SmWg_avpowgu
 YfsZ36mMJfE8nhrrxZmMq2pTp9l8vW.JWBK7L4RM4UzxM3OtQvzY0oaQiyMl7oPku0sEebsK4OHm
 yGU5OBSPXO4e3Ysx2JR72Nn8X2.32ehhYjoj20G7Kz9bzGE2kyi8g8KNl1SbsOBnpQton6zTsWke
 FAg_aNadZ6A4HNH9818Kt7aqKitWGgNcnfErQltGX0ijEDzrJs1rcBeCHsq6CKLeWrZHwPrlOH5G
 5tGxIXSyPS6JlBiL8_ggwtVT8KL9uDVSVgF.7jRrfsHpaDwWFybTlDRIE.fCpKq.Y9XCUys9eY_F
 9HmQC7d01oUZNxTbuwajtEYKxpCaO_Sfa9V_xNchM.Y5tADb1euunei7BZhnRdfArhLxMRg5yE3h
 SLG80hYWKKlMuOdT68b9fVmsRiWQrCKPfpn3gC9O8uF4HXXadzJebAAmZqO52_VZcQZ8tSck_NXl
 FYaNy45lsAuLdKNkKXjx7T4_DyiDvgJMg_orIizjBi2YNgI8eRrkVlEQ6ffzyBxJawiCoVeZ5QLP
 ZTkQB0Y.sfsImCH9ZxzaWFsZsBRRCTqy557WL8Di8SNI9JGo7KkN0HNpFNlx7TlJeh_4uMG9THBD
 PVdW.pg0KYspaimxogcnfSnSadaHRgRWiQ9nILgbaJWdZdimLd7XiMqNW4UJlGdkmNLAktjwlrsQ
 pL4BKHpP0sDdYrC1zAOCM_4vQbBH9HvP_W.a3WHqhRnkP6yudE3_1rSn.l23it8KpCHxWoYTM5mi
 JHgwbTyIC3uLiqgWNzzCugps0F6KmNF5gn6PMb9axNF7aUD1kS7y78upt_0k5RW34t6DUXkPl_G9
 eKP78AizLkpzO8cEadRwBhBtuczNcd_TZ138hyJlIWRXw02QLmcvP25VBCf96b5m5uICRyceHAdt
 7mOQ8jtrlMOpKCbjuhYiMcAJidrQIOaZqZRgteUpyQO6WsS6jbweglP3lnMBQm028AUz7_OS9Xqc
 UxI5WIf.GesMORKMGMjYU5tlDSkK5yHHc2U1C0GPblYmiTb8EMKLXflrJ5ydb4tckXnXIHzLVT4c
 nozRl9ljsR0TdEymfLK4wOVuRQAYv6hIOkP74gLOwSOvExO_v2660ChegrfHXCXTE7ytIhoLyWZU
 DEaMDFg94RFR2eFDEu4lzzUTPFBgA0GoaczXMNNeraGgF6VFceaSxA.ogXkPOelY0KgIObPZWkVq
 9tExO44umBgMRHSVOByyVg4IW1K.kdYfNuxcEAHoUmd.VkJZPiJAEp1kFy7XbjoNeKCZV.yduUBO
 8apTABXrrukUuly65oAlXImH585W0aChgWsLTb_oPlEf87RwDB0AICFh9C8pyknJBsJxexK9xaQQ
 tWudxEh6H7gKniyZVVK.qZ1QRX1V7jPCK.0dW2_EgEt.MZRXiU3GZIIlSLKuwojaTlMzKFDriMrS
 eyZyXaiqikl.qpX8esVmFVsvH82x_CsE094Ty8EItheGQz0kTZe4-
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 9 Sep 2021 16:52:38 +0000
Received: by kubenode542.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 872e521b2f971154906dd636fbfc4cca;
          Thu, 09 Sep 2021 16:52:35 +0000 (UTC)
Date:   Thu, 09 Sep 2021 12:52:31 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [PATCH] tools/perf: Use long-running addr2line per dso
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        Tony Garnock-Jones <tonyg@leastfixedpoint.com>
Cc:     linux-perf-users@vger.kernel.org
References: <20210909112202.1947499-1-tonyg@leastfixedpoint.com>
In-Reply-To: <20210909112202.1947499-1-tonyg@leastfixedpoint.com>
MIME-Version: 1.0
Message-Id: <1631205749.uhek9ofd69.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.18924 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Excerpts from Tony Garnock-Jones's message of September 9, 2021 7:22 am:
> Invoking addr2line in a separate subprocess, one for each required
> lookup, takes a terribly long time. This patch introduces a
> long-running addr2line process for each dso, *DRAMATICALLY* speeding
> up runs of perf. What used to take tens of minutes now takes tens of
> seconds.
>=20
> Debian bug report about this issue:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D911815
>=20
> Signed-off-by: Tony Garnock-Jones <tonyg@leastfixedpoint.com>

This patch seems awfully complicated, especially considering it still=20
uses relatively slow stdio instead of direct library calls. Did you look=20
into calling elfutils instead of libbfd if the latter is not available?=20
It is GPLv2 compatible, so can be linked against perf for distribution.=20
Additionally, elfutils is already used by perf for unwinding, but not=20
addr2line.

On the patch specifically, why was popen changed to socketpair? It looks=20
like it adds significant complexity, and the advanced features of=20
socketpair are not being used (SOCK_DGRAM/SOCK_SEQPACKET, SCM_RIGHTS).

Regards,
Alex.
