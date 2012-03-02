From: Victor Jimenez <victor.javier@bsc.es>
Subject: Re: Sampling instruction pointer on PPC
Date: Fri, 02 Mar 2012 20:21:35 +0100
Message-ID: <4F511DBF.7000308@bsc.es>
References: <4F4FACFA.6080209@bsc.es>
 <1330623954.4839.127.camel@oc5652146517.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3651777854804970205=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1330623954.4839.127.camel@oc5652146517.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: "Carl E. Love" <cel@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-perf-users.vger.kernel.org

This is a multi-part message in MIME format.
--===============3651777854804970205==
Content-Type: multipart/alternative;
 boundary="------------010103010902020100030706"

This is a multi-part message in MIME format.
--------------010103010902020100030706
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Carl,

On 03/01/2012 06:45 PM, Carl E. Love wrote:
> Victor:
>
> The performance counter tools perf and OProfile capture the value of the
> instruction pointer at the time an interrupt occurs. The file
> arch/powerpc/oprofile/op_model_power4.c contains the OProfile interrupt
> handler used for Power 4, 5, 6, and 7.  When the performance counters
> overflow, the instruction pointer (Program Counter) is stored in the
> SIAR register.  The perf and OProfile interrupt handlers store the
> instruction address in their samples.  These tools then use the
> addresses to create a histogram of where the processor was at the time
> of the interrupt.
>
> I am guessing you are hoping to collect something more like an raw
> sequence of addresses trying to trace where the processor was in time.
That is exactly what I want to do. Basically I want to use IP sampling 
for detecting and keeping application phase changes.
> I am not aware of a way to read the value of the instruction pointer
> directly on the fly.  But you could possibly emulate it by setting a
> program counter count value to 2^31 -1, enable the counter to count
> cycles, then read the SIAR value.  You could do this each time you want
> to take a sample.  It would require a couple reads/writes to registers.
> Note, the counter generates the interrupt to store the instruction
> pointer into the SIAR register when the most significant bit of the 32
> bit HW count value changes from 0 to 1.  You will need to then clear the
> interrupt, actually I would have to double check but I think the default
> interrupt handler that is enabled with Perf and OProfile are not running
> will do that quietly for you.
Indeed this seems like it may do the trick. Just one question; from your 
description I assume that there is no support in the current 
implementation of perf (e.g., I know perf_event_read_value() is used to 
read the value of an event, but I cannot find any equivalent function 
that can write to a counter). I guess that means I need to implement 
that in the kernel myself, right?
>
> Not sure that helps.
>
>               Carl Love
Thank you!
Victor
>
>
>
> On Thu, 2012-03-01 at 18:08 +0100, Victor Jimenez wrote:
>> I am trying to sample instruction pointer along time on a Power7 system.
>> I know that there are accurate mechanisms to do so in Intel processors
>> (e.g., PEBS and Branch Trace Store).
>>
>> Is it possible to do something similar in Power7? Will the samples be
>> accurate? I am worried that significant delays (skids) may appear.
>>
>> Thank you,
>> Victor
>>
>> WARNING / LEGAL TEXT: This message is intended only for the use of the
>> individual or entity to which it is addressed and may contain
>> information which is privileged, confidential, proprietary, or exempt
>> from disclosure under applicable law. If you are not the intended
>> recipient or the person responsible for delivering the message to the
>> intended recipient, you are strictly prohibited from disclosing,
>> distributing, copying, or in any way using this message. If you have
>> received this communication in error, please notify the sender and
>> destroy and delete any copies you may have received.
>>
>> http://www.bsc.es/disclaimer.htm
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>


-- 
------------------------------------------------------------------------

      Victor Jimenez Perez
      Barcelona Supercomputing Center
      Centro Nacional de Supercomputacion
      WWW: http://www.bsc.es         Tel: +34-934137167
      e-mail: victor.javier@bsc.es

------------------------------------------------------------------------



WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

http://www.bsc.es/disclaimer.htm
--------------010103010902020100030706
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hello Carl,<br>
    <br>
    On 03/01/2012 06:45 PM, Carl E. Love wrote:
    <blockquote
      cite="mid:1330623954.4839.127.camel@oc5652146517.ibm.com"
      type="cite">
      <pre wrap="">Victor:

The performance counter tools perf and OProfile capture the value of the
instruction pointer at the time an interrupt occurs. The file
arch/powerpc/oprofile/op_model_power4.c contains the OProfile interrupt
handler used for Power 4, 5, 6, and 7.  When the performance counters
overflow, the instruction pointer (Program Counter) is stored in the
SIAR register.  The perf and OProfile interrupt handlers store the
instruction address in their samples.  These tools then use the
addresses to create a histogram of where the processor was at the time
of the interrupt.

I am guessing you are hoping to collect something more like an raw
sequence of addresses trying to trace where the processor was in time.</pre>
    </blockquote>
    That is exactly what I want to do. Basically I want to use IP
    sampling for detecting and keeping application phase changes.<br>
    <blockquote
      cite="mid:1330623954.4839.127.camel@oc5652146517.ibm.com"
      type="cite">
      <pre wrap="">
I am not aware of a way to read the value of the instruction pointer
directly on the fly.  But you could possibly emulate it by setting a
program counter count value to 2^31 -1, enable the counter to count
cycles, then read the SIAR value.  You could do this each time you want
to take a sample.  It would require a couple reads/writes to registers.
Note, the counter generates the interrupt to store the instruction
pointer into the SIAR register when the most significant bit of the 32
bit HW count value changes from 0 to 1.  You will need to then clear the
interrupt, actually I would have to double check but I think the default
interrupt handler that is enabled with Perf and OProfile are not running
will do that quietly for you. </pre>
    </blockquote>
    Indeed this seems like it may do the trick. Just one question; from
    your description I assume that there is no support in the current
    implementation of perf (e.g., I know perf_event_read_value() is used
    to read the value of an event, but I cannot find any equivalent
    function that can write to a counter). I guess that means I need to
    implement that in the kernel myself, right?
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <blockquote
      cite="mid:1330623954.4839.127.camel@oc5652146517.ibm.com"
      type="cite">
      <pre wrap="">

Not sure that helps.

             Carl Love</pre>
    </blockquote>
    Thank you!<br>
    Victor<br>
    <blockquote
      cite="mid:1330623954.4839.127.camel@oc5652146517.ibm.com"
      type="cite">
      <pre wrap="">



On Thu, 2012-03-01 at 18:08 +0100, Victor Jimenez wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">I am trying to sample instruction pointer along time on a Power7 system. 
I know that there are accurate mechanisms to do so in Intel processors 
(e.g., PEBS and Branch Trace Store).

Is it possible to do something similar in Power7? Will the samples be 
accurate? I am worried that significant delays (skids) may appear.

Thank you,
Victor

WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

<a class="moz-txt-link-freetext" href="http://www.bsc.es/disclaimer.htm">http://www.bsc.es/disclaimer.htm</a>
--
To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
the body of a message to <a class="moz-txt-link-abbreviated" href="mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</a>
More majordomo info at  <a class="moz-txt-link-freetext" href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a>

</pre>
      </blockquote>
      <pre wrap="">

</pre>
    </blockquote>
    <br>
    <br>
    <pre class="moz-signature" cols="72">-- 
------------------------------------------------------------------------

     Victor Jimenez Perez
     Barcelona Supercomputing Center
     Centro Nacional de Supercomputacion
     WWW: <a class="moz-txt-link-freetext" href="http://www.bsc.es">http://www.bsc.es</a>         Tel: +34-934137167
     e-mail: <a class="moz-txt-link-abbreviated" href="mailto:victor.javier@bsc.es">victor.javier@bsc.es</a>

------------------------------------------------------------------------ </pre>
  
<br>
<br>
WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.
<br><br>
<a href="http://www.bsc.es/disclaimer.htm">http://www.bsc.es/disclaimer.htm</a>
<br>
</body>
</html>

--------------010103010902020100030706--

--===============3651777854804970205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
--===============3651777854804970205==--
