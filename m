From: Philipp Trommler <philipp.trommler@mailbox.tu-dresden.de>
Subject: Using perf on Xeon Phi
Date: Tue, 30 Jun 2015 12:05:10 +0200
Message-ID: <1435658710.18320.27.camel@mailbox.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mailout2.zih.tu-dresden.de ([141.30.67.73]:50450 "EHLO
	mailout2.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752894AbbF3KFM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 30 Jun 2015 06:05:12 -0400
Received: from mail.zih.tu-dresden.de ([141.76.14.4])
	by mailout2.zih.tu-dresden.de with esmtp (Exim 4.63)
	(envelope-from <philipp.trommler@mailbox.tu-dresden.de>)
	id 1Z9sPf-0002y1-3u
	for linux-perf-users@vger.kernel.org; Tue, 30 Jun 2015 12:05:11 +0200
Received: from ma013.zih.tu-dresden.de ([141.30.69.13])
	by server-50.mailclusterdns.zih.tu-dresden.de with esmtpsa (TLSv1.2:AES128-SHA:128)
	(envelope-from <philipp.trommler@mailbox.tu-dresden.de>)
	id 1Z9sPe-0004ge-ON
	for linux-perf-users@vger.kernel.org; Tue, 30 Jun 2015 12:05:10 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi!

I'd like to use perf on a Xeon Phi coprocessor and therefore I'd like
to ask if somebody on this list has already done this before.
I already tried to cross compile perf with the latest gcc (5.1) which
resulted in a non-executable binary and with Intel's icc (which failed
due to a missing libc-dependency). Can anyone help me with his or her
experiences and knowledge or point me to a good starting point or
tutorial?

Thanks in advance,
Philipp Trommler.
