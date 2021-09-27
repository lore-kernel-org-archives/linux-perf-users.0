Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2541C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 08:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB21260FC2
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 08:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhI0INH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 04:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbhI0IND (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Sep 2021 04:13:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E16C061575;
        Mon, 27 Sep 2021 01:11:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so3107314pjv.5;
        Mon, 27 Sep 2021 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zxvzFa9w3gy+pI90d1imU3SqTdR9iq61CTXXXTfiPYU=;
        b=W91OP6iT8BNmHcq2e4lnkgtoJTJ1hzJZvw2nRfall/c6XPNqapmymnMVruc1+IvBHE
         zmlWhQ0K2wF+mX+DppWhehPQVX1bS4hditALICwFEZKJb5b+klzzQfwiabLwuf065pia
         atKoqpDD+HyI1zmJ+X5wKagrdct9uOwoGX1Ej8bkiiD2zKLRzbuJ2Z5xL1WEQ+Vv7rJZ
         OKxvdUh/Vz8nbssaSUSEcNM4p5FZ9ijWtfRZ9c9jw1lX24S8ZULbdzkEokdj0diTepzK
         L9Gh7JSYF3rKpiNhyEmyupciX8LdcP9ZDLOBEJJZNTS1YYZzcjl82b/DXk1JhDRsCTS0
         4/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zxvzFa9w3gy+pI90d1imU3SqTdR9iq61CTXXXTfiPYU=;
        b=MKgMVgogwiIz6DFvlpZOxJ7Rrh1oSihZH9GNv6DSmat8soWcV184qdHT6+hOsaHE6r
         Or9DQ1gI1y6tr5I5604Rup4iB99HIuUKdEEP9D/IZk3tnizDnUZS/gOeXDcOCmJ5Fz7W
         kCo+8ct8VpFJJ89gcgKBrcNRySNIouH4Z4sKudSXSM+Vvf6D8zzqWgG0RWZ3MQY1k5Cf
         PDJi26yVFyXSa5bfi/+Oxpnk88To5HDbga1gUuLgbDTMLo3Lzs6CCHlv3jHDFAe7h4S4
         eutP3Xt7irV0Di2hDwfJo+Hs+ZPwgEUYOrC0iB4tiZ8TocpsLbevUaobuTbfEJLp13el
         QEMg==
X-Gm-Message-State: AOAM532IcGvWlKBfzn4kWGnHYOz9fZw/Oo3YGBgzHK2va3sg5k8X0jUq
        xFMrr4rU5EMgEOS8mIHVjA8=
X-Google-Smtp-Source: ABdhPJw7CR764RRc/AgUnAzD0QdslE29CFezd/TJOtZawOyucwCUa8QpiO7VEYqbHKHYaaOfVlkppQ==
X-Received: by 2002:a17:902:758b:b0:13e:8b1:e49f with SMTP id j11-20020a170902758b00b0013e08b1e49fmr10049707pll.6.1632730285241;
        Mon, 27 Sep 2021 01:11:25 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id y80sm16042240pfb.196.2021.09.27.01.11.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 01:11:24 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf iostat: Use system-wide mode if the target cpu_list is unspecified
Date:   Mon, 27 Sep 2021 16:11:14 +0800
Message-Id: <20210927081115.39568-1-likexu@tencent.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Like Xu <likexu@tencent.com>

An iostate use case like "perf iostat 0000:16,0000:97 -- ls" should be
implemented to work in system-wide mode to ensure that the output from
print_header() is consistent with the user documentation perf-iostat.txt,
rather than incorrectly assuming that the kernel does not support it:

 Error:
 The sys_perf_event_open() syscall returned with 22 (Invalid argument) \
 for event (uncore_iio_0/event=0x83,umask=0x04,ch_mask=0xF,fc_mask=0x07/).
 /bin/dmesg | grep -i perf may provide additional information.

This error is easily fixed by assigning system-wide mode by default
for IOSTAT_RUN only when the target cpu_list is unspecified.

Signed-off-by: Like Xu <likexu@tencent.com>
---
 tools/perf/builtin-stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f6e87b7be5fa..f0ecfda34ece 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2408,6 +2408,8 @@ int cmd_stat(int argc, const char **argv)
 			goto out;
 		} else if (verbose)
 			iostat_list(evsel_list, &stat_config);
+		if (iostat_mode == IOSTAT_RUN && !target__has_cpu(&target))
+			target.system_wide = true;
 	}
 
 	if (add_default_attributes())
-- 
2.32.0

