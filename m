From: Jan Heylen <heyleke@gmail.com>
Subject: perf: Kconfig based feature selection
Date: Mon, 19 Jan 2015 10:35:56 +0100
Message-ID: <CAGszK3i4ZuvCp_jSkCV26dPAeAUbjJ1PV7b0WtgmAK5Dn+1VaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:64738 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbASJf7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 19 Jan 2015 04:35:59 -0500
Received: by mail-wg0-f51.google.com with SMTP id l18so8580614wgh.10
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2015 01:35:58 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: alexis.berlemont@gmail.com, dsahern@gmail.com

Hi,

I was wondering what the status is for following item on the TODO list:

Use Kconfig to allow selecting features and build minimal version of
perf, e.g. one with just 'record' for use in embedded platforms.

David Ahern prototyped this, dig those patches and update them


I tried a search for Kconfig on this mailing list it's archives, but
no good hit.

I see in the github repos from David Ahern a link to commits from
Alexis Berlemont that look interesting, is there a plan to upstream
this?
https://github.com/aberlemont/linux/tree/perf/kbuild

One thing that I don't see is, in libperf, nothing seem to be stripped
out if you e.g. only select 'record'. Is this correct? But this
observation is only based on looking at the github repo kbuild files,
I'll have to clone Alexis his repo to have a closer look.

best regards,

Jan
