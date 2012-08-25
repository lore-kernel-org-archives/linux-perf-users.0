From: Mikolaj Konarski <mikolaj.konarski@gmail.com>
Subject: How to trace threads created by a process after perf has started
 recording, using the -p PID flag?
Date: Sat, 25 Aug 2012 14:52:42 +0200
Message-ID: <CAHFo2uodOOiTKRbeZvFFbGry8XK85unXz+_L6imgH6EeiROc0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:46228 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab2HYMwn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 25 Aug 2012 08:52:43 -0400
Received: by wibhq12 with SMTP id hq12so3999153wib.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Aug 2012 05:52:42 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Bernie Pope <florbitous@gmail.com>, Duncan Coutts <duncan@well-typed.com>

Hi,

Could someone clarify the behaviour of the -p PID flag of perf-record?
In our experiments (3.2.0-27 #43-Ubuntu SMP x86_64),
it ignores events on threads spawned after perf-record is started.
Is this the intended behaviour, and is there any work-around?

Generally, what is the best (vs CPU/IO, distortion of profiling results)
way to record only events of a given OS process, with all its threads?

Thanks a lot,
Mikolaj
