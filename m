Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BC0C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Dec 2022 17:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLHRmM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Dec 2022 12:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLHRmJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Dec 2022 12:42:09 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FD77E80C
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Dec 2022 09:42:07 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id c184so2147325vsc.3
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Dec 2022 09:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLBXt2Jtw0kYFWpcJPTwwMQ6BDpS6jKcsiWh2x9aQ68=;
        b=q1rHnTY7Tadre4D+fqST2ld7So3s26m9HTLgoPCGDo1koR1yer4RbVIKn4L+Y2qbuU
         uW177VPnbUlziy1OucBIa1tm/gBCzOldbcB9kxUM1pn89texknSond0wO8diqwQIhcFY
         eKL6S8X2C/FaeIVDdJixZcJvZYjmLrrgBxZ5CBtywJC7ULgeultgKTu1tVT34nc3Z4b3
         PxJiKpJ8IAQZ9CLlkhSOj047IpG9ZjTgUPHarmjfF43MsGEmQrBKgSd+WefifG3W8q69
         zUPZbGp5ATTqyylOG6Mmj0VZBi+kYd7T7zIFLgwfePAbUWZkUndclxJa8QjLP+t/LWaB
         CjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLBXt2Jtw0kYFWpcJPTwwMQ6BDpS6jKcsiWh2x9aQ68=;
        b=6qHrRPqH03cEWuMMYr+w9b9PWO6hXzrHeGzTAaiCDYnsT9d7VZd5I2ydngmLVlnV2Y
         yBJrQuz3SlzyWxw6Ezhm1UAFwKyRRllL5IaWHRSkGCqUA3fE+05r9pzfhuTRHuz4ET1T
         hBr4/TVN8qSmmR4z3MgVEsJZa0wVjn2PP/ogjsOANKOePuwl32vR5XAOsuRXYPtb5lfm
         J8qtoYFJQSvegUpc2Z/2TyoF30Ix7AZeXTbbbSzrRwnYMdXZ8WP7+tON9vdi1JKzUrMJ
         is1TkXppnbUZkCogvfa4K7yGvFpb21859Oh/pB33tV+F+mFr4b+mpKissEQ7jHFracBT
         1n9w==
X-Gm-Message-State: ANoB5pmwZjycRADLTitRNV2dUT1vE3RgFt6OuQ5sOxmlETkPdfZqj28W
        POB4KL7LoCIG3UMEV5jV+jZpM9lzqVoKDB5sZ/oD3A==
X-Google-Smtp-Source: AA0mqf5988ezjzMU+pj3GZmQT8TbVYw3+msm3Gje3bceuHYPjEBbPuSHL9bVhPvP+54fI00E0UUCZLYWZcEtwKIds40=
X-Received: by 2002:a05:6102:114b:b0:3b0:5300:a99b with SMTP id
 j11-20020a056102114b00b003b05300a99bmr43661599vsg.23.1670521326913; Thu, 08
 Dec 2022 09:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20221207055908.1385448-1-irogers@google.com> <Y5DQKif+PdRJblk+@kernel.org>
 <0d64e485-5acf-b7ad-e228-9bf85d8ae16d@oracle.com> <Y5DRjecE88KFc4He@kernel.org>
In-Reply-To: <Y5DRjecE88KFc4He@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 8 Dec 2022 09:41:55 -0800
Message-ID: <CAP-5=fWa=zNK_ecpWGoGggHCQx7z-oW0eGMQf19Maywg0QK=4g@mail.gmail.com>
Subject: Re: [PATCH v4] perf jevents: Parse metrics during conversion
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Apologies, I found an issue with a double-if. Could you add the 1 line
fix plus test:

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric=
.py
index cc451a265751..4797ed4fd817 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -462,6 +462,7 @@ class _RewriteIfExpToSelect(ast.NodeTransformer):

  def visit_IfExp(self, node):
    # pylint: disable=3Dinvalid-name
+    self.generic_visit(node)
    call =3D ast.Call(
        func=3Dast.Name(id=3D'Select', ctx=3Dast.Load()),
        args=3D[node.body, node.test, node.orelse],
diff --git a/tools/perf/pmu-events/metric_test.py
b/tools/perf/pmu-events/metric_test.py
index 4741b7b6612d..6980f452df0a 100644
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -87,6 +87,10 @@ class TestMetricExpressions(unittest.TestCase):
    after =3D r'min((a + b if c > 1 else c + d), e + f)'
    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)

+    before =3D r'a if b else c if d else e'
+    after =3D r'(a if b else (c if d else e))'
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
  def test_ToPython(self):
    # pylint: disable=3Deval-used
    # Based on an example of a real metric.

Thanks,
Ian

On Wed, Dec 7, 2022 at 9:47 AM Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>
> Em Wed, Dec 07, 2022 at 05:42:52PM +0000, John Garry escreveu:
> > On 07/12/2022 17:40, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Dec 06, 2022 at 09:59:08PM -0800, Ian Rogers escreveu:
> > > > Currently the 'MetricExpr' json value is passed from the json
> > > > file to the pmu-events.c. This change introduces an expression
> > > > tree that is parsed into. The parsing is done largely by using
> > > > operator overloading and python's 'eval' function. Two advantages
> > > > in doing this are:
> > > John, what tag can I get from you? =F0=9F=98=84
> > >
> > > - Arnaldo
> > Sure,
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
>
> Thanks a lot!
>
> - Arnaldo
