From: Jan Heylen <heyleke@gmail.com>
Subject: pipe_output format different from file output?
Date: Tue, 20 Jan 2015 16:03:10 +0100
Message-ID: <CAGszK3ji6h_GkzqSJ59Eyw+4ALj+pwxcRb41Y65ZC-eKjiz3bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:47559 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbbATPDM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Jan 2015 10:03:12 -0500
Received: by mail-wi0-f174.google.com with SMTP id n3so4058415wiv.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2015 07:03:10 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: jolsa@redhat.com

Hi,

working with perf record, I noticed following behavior:

# perf record sleep 1
# perf report -i perf.data
--> expected output
(note: -i perf.data not really needed)

# perf record -o - sleep 1 | cat > perf.data
# perf report -i perf.data
--> incompatible file format (rerun with -v to learn more)
# perf report -i - < perf.data
--> expected output

I see indeed in the code that the perf_session__process_events in
session.c makes a difference on where the samples are coming from, but
I was wondering what the exact difference is, and if it would be
possible to convert a pipe_output generated file to a 'normal' one?

I tried to lookup on the wiki and various tutorials what the
difference is, but no success.

The reason I want to use the pipe is to do streaming compression of
the output of perf:
# perf record -o - sleep 1 | gzip -c > perf.data.gz

But without knowing the pipe_output difference, one could do:
# gzip -d perf.data.gz
# perf report -i perf.data

Now I see that that is not possible, I'll do/document it as
# gzip -d -c perf.data.gz | perf report

But I still want to understand why there is a difference (and what is
the consequence of using the pipe_output format)

best regards,

Jan
