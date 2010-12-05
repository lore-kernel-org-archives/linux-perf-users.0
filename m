From: john smith <whalajam@yahoo.com>
Subject: perf counters, relative costs
Date: Sat, 4 Dec 2010 16:35:46 -0800 (PST)
Message-ID: <513818.44008.qm@web55007.mail.re4.yahoo.com>
References: <1264533715.4283.1961.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from web55007.mail.re4.yahoo.com ([206.190.58.141]:29689 "HELO
	web55007.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755025Ab0LEAm1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 4 Dec 2010 19:42:27 -0500
In-Reply-To: <1264533715.4283.1961.camel@laptop>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

One piece of info that I couldn't find anywhere is a table with the relative cost (e.g. a 1..100 scale) of all these HW or SW counters/events.
What are the events that have the most..least effect on performance?
The changes required - to increase the performance - should depend not only on the (high) reported counters values but also on their "weight". The "counter_value x counter_weight" is the actual meaningful (performance-wise) value.
I understand that creating such a table is time consuming and not too interesting but I think is necessary for an time-efficient performance improvement approach,

thanks,
John



      
