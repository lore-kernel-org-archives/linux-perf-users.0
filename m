From: Manuel Selva <selva.manuel@gmail.com>
Subject: Perf mem report Data Object
Date: Wed, 29 Jan 2014 14:53:28 +0100
Message-ID: <CALbiyZzdM84Cy+sodbuxPxT1jRZs4W94-N0KCjyaw3K89Edh3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:62955 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbaA2Nxa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Jan 2014 08:53:30 -0500
Received: by mail-lb0-f170.google.com with SMTP id u14so1472795lbd.15
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2014 05:53:29 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

The perf mem report tools shows me a warning before printing results:

Failed to open /tmp/perf-8741.map, continuing without symbols

Then it seems that all the memory accesses which source address (Data
Symbol field in perf mem rep output) is located in the heap of the
profiled process is reported as "perf-8741.map" in the Data Object
field.

I am not sure to understand what this file is, what it should contain,
and why it's not created when my process is profiled ?

Moreover, I am wondering what perf mem could report for heap data
object in addition to the fact that the object is in the heap ?

Thanks,

-------
Manu
