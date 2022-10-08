Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212CFC433FE
	for <linux-perf-users@archiver.kernel.org>; Sat,  8 Oct 2022 03:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJHDx0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 Oct 2022 23:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJHDxZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 Oct 2022 23:53:25 -0400
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F177D7E835
        for <linux-perf-users@vger.kernel.org>; Fri,  7 Oct 2022 20:53:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; bh=RPvIHMnxNZqw0/E1mYOh34M7wrdUyzxHHFnZw597LG4=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20221003; t=1665201195; v=1; x=1665633195;
 b=c6sv2Sb3QwsHxeIMkeBxYN0dQFVsJXGlHGjKWcohFADCvsylxV7nBDWLDZ/lZEhqn4XLoWT/
 wZBqyBTK1Fimi0gYfe4odG/msDWJ+fTyH9kpz48F7CZpZqsS06MRS1+AK9kQ39/kboeEY3YX4wn
 /wEzy9whj2Wuh6omeUz1yADCvMLfIfN/9zr4rfR3LqgRr0oki+Up6jDMzAVJXOPZg8eaiVIcUjD
 p9vByilzdbvBUZYoUjZYkZw0EIrBqp0cMKkcHQugp4ttzix0SGDoqByBLBcyAK/O8JpffHHr1Sy
 PNRphjCXKqOyGtwBccmR7d4iDnquw1PcilCKimFbbZdMINmSBgAdZ14K4bpraZi4Tz+Lpx/6lz6
 JZlnWzkPFViSrZuIjEbRu/Fu45JNYdt6gtp8JV2ByrMEFgFzqCZpOEFnIYmpjnvIoE3YnHT9Ws6
 htcrZMoLmgF6Ixc+PQgZMwQmXtATG51nkP+yRgL+4mQU9yLqJ6U7b5yUy6OEZlKltsGgYZi0rER
 /Za08dUCpBYOkVhnMdU4kMyS/I9szLInYgO/u2Ik7ut/3EJuq+j6FJ3TuR2Iv/cBSVS6cwkSaGq
 6g4ORe9Ur2IONN0z8g4N7VVGa+MWt08XQdZ1L5G5cPmf8DO49dR8JHf2uIiuU5XVORop65SwuLd
 FIKbRMAwG5Y=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id b0e6ba90; Fri, 07 Oct
 2022 23:53:15 -0400
MIME-Version: 1.0
Date:   Fri, 07 Oct 2022 23:53:15 -0400
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     linux-perf-users@vger.kernel.org
Subject: Recent perf-tools does not compile on alpha
Message-ID: <43a0c856c61f0bee69290b82c7bd8e7a@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi!  Recent versions of the perf tools (5.19) do not compile on alpha 
with the following errors:

util/unwind-libdw.c: In function ‘memory_read’:
util/unwind-libdw.c:161:62: error: ‘PERF_REG_SP’ undeclared (first use 
in this function); did you mean ‘PERF_MEM_S’?
   161 |         ret = perf_reg_value(&start, &ui->sample->user_regs, 
PERF_REG_SP);
       |                                                              
^~~~~~~~~~~
       |                                                              
PERF_MEM_S
util/unwind-libdw.c:161:62: note: each undeclared identifier is reported 
only once for each function it appears in
util/unwind-libdw.c: In function ‘unwind__get_entries’:
util/unwind-libdw.c:255:53: error: ‘PERF_REG_IP’ undeclared (first use 
in this function); did you mean ‘PERF_REGS_MAX’?
   255 |         err = perf_reg_value(&ip, &data->user_regs, 
PERF_REG_IP);
       |                                                     ^~~~~~~~~~~
       |                                                     
PERF_REGS_MAX

Wondering if anybody has some pointers about where these definitions 
should be coming from on alpha?
