From: AmirReza Ghods <ar.ghods@gmail.com>
Subject: Fwd: The overhead of sampling in perf record
Date: Thu, 7 Nov 2013 00:46:06 +0000
Message-ID: <CAOJauODPXaVmumdKTzsQhbo3uwR1EH-+CL2XdeQC2L-LexAVdg@mail.gmail.com>
References: <CAOJauOC53oai36QmGy19H_z51E7P4eBoQJympuz0_Z9j=3f6Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:48362 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab3KGAqH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 6 Nov 2013 19:46:07 -0500
Received: by mail-ie0-f178.google.com with SMTP id x13so498533ief.23
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2013 16:46:06 -0800 (PST)
In-Reply-To: <CAOJauOC53oai36QmGy19H_z51E7P4eBoQJympuz0_Z9j=3f6Sg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

Could you please explain the overhead of sampling with perf record? I
mean, when I do sampling with high frequencies, such as 10000Hz, the
accuracy of counting the events decreases. I want to know the exact
source of overheads which makes the results less accurate.

Best,
Amir
