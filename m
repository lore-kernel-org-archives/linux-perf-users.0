From: Mark Hills <mark@pogo.org.uk>
Subject: perf and gprof2dot
Date: Mon, 17 Oct 2011 17:38:22 +0100 (BST)
Message-ID: <1110171539460.18449@jrf.vwaro.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx.ij.cx ([212.13.201.15]:60064 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756584Ab1JQREP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Oct 2011 13:04:15 -0400
Received: from mark (helo=localhost)
	by wes.ijneb.com with local-esmtp (Exim 4.71)
	(envelope-from <mark@pogo.org.uk>)
	id 1RFqCk-0002Ak-W3
	for linux-perf-users@vger.kernel.org; Mon, 17 Oct 2011 17:38:23 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I'm using perf very successfully, and recently in place of oprofile.

But I wondered if there is a way for 'perf report' to output a gprof-style 
callgraph (similar to 'oprofile -c')?

Aside from being familiar, the motivation is so that it can be displayed 
as a directed graph (not tree) by the excellent gprof2dot [1] tool.

Many thanks

[1] http://code.google.com/p/jrfonseca/wiki/Gprof2Dot

-- 
Mark
