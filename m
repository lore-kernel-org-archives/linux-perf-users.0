From: taeung <treeze.taeung@gmail.com>
Subject: What does several of perf configurations (alias, help, call-graph)
 mean ?
Date: Thu, 05 Feb 2015 17:04:58 +0900
Message-ID: <54D3242A.8050606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:40147 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbbBEIFG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 5 Feb 2015 03:05:06 -0500
Received: by mail-pa0-f45.google.com with SMTP id et14so8488533pad.4
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2015 00:05:05 -0800 (PST)
Received: from [123.140.74.165] ([123.140.74.165])
        by mx.google.com with ESMTPSA id nm8sm4209476pdb.36.2015.02.05.00.05.03
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2015 00:05:04 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


Hi, every one. :-)

I'm tring to make things about perf configuration neat and tidy.
Three questions have arisen doing it.

1. alias [ util/alias.c : alias_lookup_cb(), util/help.c : 
perf_unknown_cmd_config() ]

         What kind of alias keys are there ?

2. help [ builtin-help.c : perf_help_config() ]

         'autocorrect' can have a value of integer type.
         What does the value mean ?

3. call-graph [ util/callchain.c : perf_callchain_config(), 
parse_callchain_record_opt() ]

         record-mode can be 'Framepointer style' or  'Dwarf style'.
         Why does 'Dwarf style' accompany dump-size ?

         'threshold' can have a value of double type
         and the value can be entered into callchain_param.min_percent.
         What does 'threshold' mean ?


Thanks,
Taeung
