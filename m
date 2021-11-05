Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3D9C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 05:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39AF66127C
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 05:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhKEGAe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 02:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKEGAd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Nov 2021 02:00:33 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843FBC061714;
        Thu,  4 Nov 2021 22:57:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u141so49957pfc.4;
        Thu, 04 Nov 2021 22:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=eEB4ecQ1ZNfPcSQu/zCsmgppD0Z0jo0HIyobZ6E/qyg=;
        b=Y+blWID2npSQxlMePFKmMcv5UVywvYlMNsfojW9np0A1qJ6MelqQc5oCMuXl6VsZ+s
         V1Nhqx9o/tsR926wRMShOLYCTuPVE5G6fzUXBAw29CgP4IkA0qTPP0MS3OytHQu4Dx3r
         hu+Zr9ny2mlbKxjUwUqhvQQ7dlyqvWtFZ+SZmMvdFl3l3n+dO/b8ifEcBgc6OzmnCtpq
         JO9lempYHsMHMq63RtfRFjCyv9lEUnJapf2tEGrzHlEgq7T2XEivggBj96NkBcBxyUAx
         lKkf/zv8/td9449EN6rkG+8fEbbdS71qWXkiP8TB1deibDqjJnNr7yaOoetf1pI1Pomv
         4b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=eEB4ecQ1ZNfPcSQu/zCsmgppD0Z0jo0HIyobZ6E/qyg=;
        b=PxafpB4rUHfSjHUUmNIAYnIhsot40RutKqmlddDDMBkAxtsUlWTKFcYFzFaUcKnh3L
         lhLC1mKsNezbxnHtM/1FQpyffiBUPeFDHARKZyhJ8cqhyrjWkA9ozqHeJ4PEnhAfyJiS
         5vx5Vvsl+VExs+BsiU9oDyCnpfEG95A4PhEB8YZztjBEywkdDdU+Mf84KXDLPpBddULZ
         p1Y/p1yfAou9Om37gnr+YvCq79Omu7eE6kH33tBh+cZqjykyXXyF4mXwqDLIiRtTbqEP
         jQpODvyXBiR72F7vm61qJAsVBIjN8n90lF2QiUDtBbTy47MYBlcWAdnCw8Fejgf0wu+G
         p6oQ==
X-Gm-Message-State: AOAM530o4Ra7gNlIEHE10aS2DzoDMzd0Zpeu2YYP8xOZiJl56TpQblA0
        001ofpVgM0Xp57ykYO+rLwXfvue1HXfSzw==
X-Google-Smtp-Source: ABdhPJzbmQ0sB5kZR3aLa3IV/icD5aM3UqNE1fillfV2M0WPg6cywdIuDVekdoHk0rcww34n3SJA2w==
X-Received: by 2002:a05:6a00:887:b0:474:1f41:2293 with SMTP id q7-20020a056a00088700b004741f412293mr57521929pfj.44.1636091873782;
        Thu, 04 Nov 2021 22:57:53 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id d12sm6925990pfl.141.2021.11.04.22.57.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Nov 2021 22:57:53 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Using perf_event_open() to sample multiple events of a process
Message-Id: <92645262-D319-4068-9C44-2409EF44888E@gmail.com>
Date:   Thu, 4 Nov 2021 22:57:50 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
To:     kan.liang@linux.intel.com, Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Ken, Peter,

I would appreciate some help regarding the use of perf_event_open()
to have multiple samples getting into the same mmap=E2=80=99d memory =
when they
are both attached to the same process.

I am doing so (using both PERF_FLAG_FD_NO_GROUP and =
PERF_FLAG_FD_OUTPUT),
but it results in -EINVAL. Debugging the code shows that
perf_event_set_output() fails due to the following check:

        /*
         * If its not a per-cpu rb, it must be the same task.
         */
        if (output_event->cpu =3D=3D -1 && output_event->ctx !=3D =
event->ctx)
                goto out;

However, it appears that at this point, event->ctx is not initialized
(it is null) so the test fails and the whole perf_event_open() syscall
fails.

Am I missing something? If not, I am unsure, unfortunately, what the
proper way to fix it is=E2=80=A6

I include a small test that fails on my system. The second
perf_event_open fails due to the check in perf_event_set_output():




#define _GNU_SOURCE 1

#include <asm/unistd.h>
#include <linux/perf_event.h>
#include <linux/hw_breakpoint.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

long perf_event_open(struct perf_event_attr* event_attr, pid_t pid, int =
cpu,
		     int group_fd, unsigned long flags)
{
    return syscall(__NR_perf_event_open, event_attr, pid, cpu, group_fd, =
flags);
}

int main(void)
{
	pid_t pid =3D getpid();
	int group_fd, fd;
	void *p;
	struct perf_event_attr pe =3D {
		.type =3D 4,
		.size =3D sizeof(struct perf_event_attr),
		.config =3D 0x11d0,
		.sample_type =3D 0x8,
		.sample_period =3D 1000,
		.precise_ip =3D 2,
	};

	group_fd =3D perf_event_open(&pe, pid, -1, -1, =
PERF_FLAG_FD_CLOEXEC |=20
						     =
PERF_FLAG_FD_NO_GROUP |
						     =
PERF_FLAG_FD_OUTPUT);

	if (group_fd < 0) {
		perror("first perf_event_open");
		exit(-1);
	}

	p =3D mmap(NULL, 3 * 4096, PROT_READ|PROT_WRITE, MAP_SHARED, =
group_fd, 0);

	if (p =3D=3D MAP_FAILED) {
		perror("MAP_FAILED");
		exit(-1);
	}
=09
	pe.config =3D 0x12d0;
=09
	fd =3D perf_event_open(&pe, pid, -1, group_fd, =
PERF_FLAG_FD_CLOEXEC |=20
						     =
PERF_FLAG_FD_NO_GROUP |
						     =
PERF_FLAG_FD_OUTPUT);

	if (fd < 0) {
		perror("second perf_event_open");
		exit(-1);
	}

	printf("success\n");
}

