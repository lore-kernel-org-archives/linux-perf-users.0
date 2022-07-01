Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C7FC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  1 Jul 2022 12:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiGAMJA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 1 Jul 2022 08:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiGAMJA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Jul 2022 08:09:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EA451FCE5;
        Fri,  1 Jul 2022 05:08:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B25113E;
        Fri,  1 Jul 2022 05:08:59 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.71.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 105CB3F792;
        Fri,  1 Jul 2022 05:08:57 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Patch series to add to and imporve tests for CoreSight
Date:   Fri,  1 Jul 2022 13:07:49 +0100
Message-Id: <20220701120804.3226396-1-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
Reply-To: carsten.haitzler@foss.arm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This improves how perf test handles finding shell scripts to run as
part of the testing allowing sub-directories, skipping files that
are not intentional shell script tests and then adds a set of tests
that improve what we cover for Arm CoreSight testing. The goal of
these tests is to expand the scenarios and data traced and examined
to track quality of trace data and improvements to that over time.

Eventually it'd be neater to break up the current Arm CoreSight tests
into smaller focused tests that share the same infrastructure, but
this here would be a first step.


