From: Ben Redelings <benjamin.redelings@gmail.com>
Subject: "perf script" broken with --call-graph=dwarf on recent kernels?
Date: Mon, 17 Aug 2015 12:25:29 -0400
Message-ID: <55D20AF9.9040705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33199 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbbHQQZg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Aug 2015 12:25:36 -0400
Received: by qged69 with SMTP id d69so97000677qge.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2015 09:25:36 -0700 (PDT)
Received: from [10.180.16.77] ([152.3.43.230])
        by smtp.googlemail.com with ESMTPSA id f194sm8535594qka.49.2015.08.17.09.25.35
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2015 09:25:35 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

     The behavior of "perf script" has changed on recent kernels, and 
I'm wondering whether this is a bug, or whether I'm just missing 
something.  (I'm perf script to generate DOT graphs for user-space 
profiling via the gprof2dot script: https://github.com/jrfonseca/gprof2dot)

     If I run perf record with --call-graph=dwarf, then I can run perf 
report and view call-chains.  However, if I run 'perf script' I don't 
see any call chains, but just output like:

bali-phy 11043 10381.662885:     466982 cycles:

bali-phy 11043 10381.663136:     466737 cycles:

bali-phy 11043 10381.663386:     466456 cycles:

bali-phy 11043 10381.663636:     466465 cycles:

bali-phy 11043 10381.663885:     466611 cycles:

bali-phy 11043 10381.664135:     466757 cycles:

with an occasional

bali-phy 11043 10381.665885:     466867 cycles:
         ffffffff81577e30 page_fault ([kernel.kallsyms])

     If I run with --call-graph=lbr instead, then I get 'perf script' 
output like this instead:

bali-phy 11060 10464.369184:     420718 cycles:
                   3437d0 all_characters_connected 
(/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)
                   3448c8 check_internal_nodes_connected 
(/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)
                   3450fc check_alignment 
(/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)

bali-phy 11060 10464.369412:     427217 cycles:
                   26ef10 alignment::alignment 
(/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)
                   305f7e empirical_frequencies 
(/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)
                   306ce1 empirical_frequencies 
(/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)
                   3330d9 get_smodel 
(/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)
                   4dc133 get_smodels 
(/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)
                   4e02ea create_A_and_T_model 
(/home/bredelings/Devel/bali-phy/local/clang-3.7/bin/bali-phy)

This is more what I was expecting, and similar to what I used to get 
with --call-graph=dwarf.

However, the call chains that I get using DWARF tend to be longer and 
lead to more accurate results, so I would prefer to use DWARF instead of 
lbr.  Is there something that I'm doing wrong?  Also, it seems like 
--call-graph=dwarf successfully records call chains that can be seen via 
perf report, but somehow 'perf script' doesn't show them.  Could that 
happen?

-BenRI

P.S. I'm using debian's kernel 4.1.0 and perf tools on a Core i3-4030.
