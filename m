From: Elena Talkova <e.talkova@zoho.eu>
Subject: Re: QEMU-KVM metrics collection | Calculation of instructions
 performed from perf events
Date: Mon, 10 Jul 2017 12:31:24 +0300
Message-ID: <15d2bd6d01c.f99905db124156.8759706603316104179@zoho.eu>
References: <15d0cf6ed40.ad8fdbd059031.2271426277329799808@zoho.eu> <874luq7qd9.fsf@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sender21-mail.zoho.eu ([31.186.226.21]:21596 "EHLO
        sender21-mail.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbdGJJbb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jul 2017 05:31:31 -0400
In-Reply-To: <874luq7qd9.fsf@firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>


Hi Andi,

Thank you for your response. 

 > You would need a better definition. There's no way 
 > to count "all integer" instructions. Just all instructions, 
 > or some specific classes of instructions. 

Yes, makes sense. When you talk about the specific classes of instructions, which ones do you mean? For example, would it be possible to get data about such classes as addition, subtraction, multiplication and division?

From the other perspective, I've been trying to collect the data about integer/floating-point instructions performed to calculate corresponding OPS. Are there enough counters available for micro-operations so that I can get this info skipping the instructions data?

Thanks in advance for your attention :)

Best regards, Elena


 ---- On Wed, 05 Jul 2017 20:20:02 +0300 Andi Kleen <andi@firstfloor.org> wrote ---- 
 > Elena Talkova <e.talkova@zoho.eu> writes: 
 > > 
 > > I have 2 problems so far: 
 > > 
 > > 1) I'm not sure how to use all available events to calculate number of instructions performed (integer and floating-points) 
 >  
 > You would need a better definition. There's no way 
 > to count "all integer" instructions. Just all instructions, 
 > or some specific classes of instructions. 
 >  
 > If you need an exact instruction histogram the only 
 > way is to use special instrumentation tools like pin. 
 >  
 > > 2) I get totally different results when running perf for a process on 
 > > host machine and for a virtual machine process (with VM values often 
 > > being just zeros) 
 >  
 > Measuring the counts from the host should work, except for 
 > PEBS events. 
 >  
 > > Sandy bridge: 
 > > 
 > > FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE 
 >  
 > These events are difficult to use because they include speculative and 
 > re-issued execution, which can be high. Typically you need a significant 
 > workload specific correction factor. 
 >  
 > The retired Broadwell, Skylake events below don't have this problem. But it's 
 > still not "all floating point" instructions, just all floating point 
 > arithmetic. 
 >  
 > -Andi 
 > -- 
 > To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in 
 > the body of a message to majordomo@vger.kernel.org 
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html 
 > 
