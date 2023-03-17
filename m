Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0E9C6FD1F
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Mar 2023 01:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCQBnb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Mar 2023 21:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCQBna (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Mar 2023 21:43:30 -0400
Received: from s01.bc.larksuite.com (s01.bc.larksuite.com [209.127.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7048F1CF7E
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Mar 2023 18:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lixiang-com.20200927.dkim.feishu.cn; t=1679017401;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=5H23Oqzu+el31Fgo+S6K1rDmiKk/NTTps8WNAfD/NK0=;
 b=YZ2WR83Ydenjb18khQiDs2+x7t7/fk+9RgDJES/uXV27Hs/g3XTmKsyyMDjbQRXcPp5NdN
 o9qPw0D7d8IZYpnMgarKPs8V8U7fBEQXqVLcx+vKwAe/hk3MCj9pWamguqlgXpA273yH2Z
 bmWivWK2QeZkxeK3uGv0Wb6uEfX+otolTdyw300iT0la4kgo/J4khIcuoQbYpoc+3HzT/C
 HDUiWwV9vnPLLvZ7gMdlqipl6mPBOeKtDJAAnVwDo0I8Q64o3Pl99wjH09Nja1cqRccAtJ
 mvuBpvyU+hZKFFBVJePKkzEsWvt7zZ7SA1SoXrB4rKeQnTjirLXVaNVVYK3bkg==
Subject: [PATCH v2] perf sched: Fix sched latency analysis incorrect
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary=439a3ed0d0e2c524da0761105606487f6c82c83e31680744ffa063e39ec2
X-Lms-Return-Path: <lba+26413c5ae+a252d6+vger.kernel.org+zangchunxin@lixiang.com>
To:     <namhyung@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>
Cc:     <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Chunxin Zang" <zangchunxin@lixiang.com>,
        "Jerry Zhou" <zhouchunhua@lixiang.com>
X-Mailer: git-send-email 2.25.1
From:   "Chunxin Zang" <zangchunxin@lixiang.com>
Date:   Fri, 17 Mar 2023 09:43:10 +0800
Message-Id: <20230317014303.949808-1-zangchunxin@lixiang.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

--439a3ed0d0e2c524da0761105606487f6c82c83e31680744ffa063e39ec2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

'perf sched latency' is incorrect to get process schedule latency
when it used 'sched:sched_wakeup' to analysis perf.data.

Because 'perf record' prefer use 'sched:sched_waking' to
'sched:sched_wakeup' since commit d566a9c2d482 ("perf sched: Prefer
sched_waking event when it exists"). It's very reasonable to
evaluate process schedule latency.

Similarly, update sched latency/map/replay to use sched_waking events.

I used 'perf record -e =E2=80=9Csched:* "' to record both wakeup and waking=
 events,
and use fixed perf version to analysis them, the result is correct.
Because the function "latency_wakeup_event=E2=80=9D will change atom->state=
 to
THREAD_WAIT_CPU at waking event, and judge the 'atom->state !=3D THREAD_SLE=
EPING=E2=80=99
is false then returned at wakeup event.

Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
Signed-off-by: Jerry Zhou <zhouchunhua@lixiang.com>
---
 tools/perf/builtin-sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 86e18575c9be..1af4ec1ac824 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1819,6 +1819,7 @@ static int perf_sched__read_events(struct perf_sched =
*sched)
 	const struct evsel_str_handler handlers[] =3D {
 		{ "sched:sched_switch",	      process_sched_switch_event, },
 		{ "sched:sched_stat_runtime", process_sched_runtime_event, },
+		{ "sched:sched_waking",	      process_sched_wakeup_event, },
 		{ "sched:sched_wakeup",	      process_sched_wakeup_event, },
 		{ "sched:sched_wakeup_new",   process_sched_wakeup_event, },
 		{ "sched:sched_migrate_task", process_sched_migrate_task_event, },
--=20
2.25.1

=E5=A3=B0=E6=98=8E=EF=BC=9A=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E5=8F=AA=E5=
=85=81=E8=AE=B8=E6=96=87=E4=BB=B6=E6=8E=A5=E6=94=B6=E8=80=85=E9=98=85=E8=AF=
=BB=EF=BC=8C=E6=9C=89=E5=BE=88=E9=AB=98=E7=9A=84=E6=9C=BA=E5=AF=86=E6=80=A7=
=E8=A6=81=E6=B1=82=E3=80=82=E7=A6=81=E6=AD=A2=E5=85=B6=E4=BB=96=E4=BA=BA=E4=
=BD=BF=E7=94=A8=E3=80=81=E6=89=93=E5=BC=80=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=
=96=E8=BD=AC=E5=8F=91=E9=87=8C=E9=9D=A2=E7=9A=84=E4=BB=BB=E4=BD=95=E5=86=85=
=E5=AE=B9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E9=82=AE=E4=BB=B6=E9=94=99=E8=
=AF=AF=E5=9C=B0=E5=8F=91=E7=BB=99=E4=BA=86=E4=BD=A0=EF=BC=8C=E8=AF=B7=E8=81=
=94=E7=B3=BB=E9=82=AE=E4=BB=B6=E5=8F=91=E5=87=BA=E8=80=85=E5=B9=B6=E5=88=A0=
=E9=99=A4=E8=BF=99=E4=B8=AA=E6=96=87=E4=BB=B6=E3=80=82=E6=9C=BA=E5=AF=86=E5=
=8F=8A=E6=B3=95=E5=BE=8B=E7=9A=84=E7=89=B9=E6=9D=83=E5=B9=B6=E4=B8=8D=E5=9B=
=A0=E4=B8=BA=E8=AF=AF=E5=8F=91=E9=82=AE=E4=BB=B6=E8=80=8C=E6=94=BE=E5=BC=83=
=E6=88=96=E4=B8=A7=E5=A4=B1=E3=80=82=E4=BB=BB=E4=BD=95=E6=8F=90=E5=87=BA=E7=
=9A=84=E8=A7=82=E7=82=B9=E6=88=96=E6=84=8F=E8=A7=81=E5=8F=AA=E5=B1=9E=E4=BA=
=8E=E4=BD=9C=E8=80=85=E7=9A=84=E4=B8=AA=E4=BA=BA=E8=A7=81=E8=A7=A3=EF=BC=8C=
=E5=B9=B6=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=BB=A3=E8=A1=A8=E6=9C=AC=E5=85=AC=E5=
=8F=B8=E3=80=82
--439a3ed0d0e2c524da0761105606487f6c82c83e31680744ffa063e39ec2--
