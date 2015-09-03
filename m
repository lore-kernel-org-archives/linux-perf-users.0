From: Dennis Gnad <dennis.gnad@kit.edu>
Subject: Re: Understanding timestamps in perf.data
Date: Thu, 3 Sep 2015 16:46:54 +0200
Message-ID: <55E85D5E.90400@kit.edu>
References: <55E6C120.3030504@kit.edu> <55E6FCF9.60403@gmail.com>
 <55E71351.8010507@kit.edu> <55E72762.6030209@gmail.com>
 <alpine.DEB.2.20.1509021256550.575@vincent-weaver-1.umelst.maine.edu>
 <55E7F47C.2000403@kit.edu>
 <alpine.DEB.2.20.1509030849190.3450@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from scc-mailout-kit-02.scc.kit.edu ([129.13.231.82]:40052 "EHLO
	scc-mailout-kit-02.scc.kit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752004AbbICOrB (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 3 Sep 2015 10:47:01 -0400
In-Reply-To: <alpine.DEB.2.20.1509030849190.3450@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

On 03.09.2015 14:52, Vince Weaver wrote
>
> The kernel itself has trouble going to 100Hz without causing a lot of
> overhead and at 1kHz the NMI overhead gets high enough that the kernel
> throttles things down.  I haven't investigated why that is, it might be a
> problem with how my tool is coded.  For now I just gave up and am making
> masurements at 10Hz.
OK thanks for this information. I can probably now exclude the current 
perf-interface of the kernel.

Maybe this is also interesting for you then:

In the meantime I got some information for the x86 architecture. There, 
the performance counters can be read directly in userspace by the 
interface over MSR's similar to readmsr/msrtool, where a reliable 
interval of <10ms can be achieved. [1]

For ARM, there seems to exist some specialized driver "gator" which I 
didn't take a closer look.

Anyhow, I am currently looking at a Power7 system, and don't know of any 
other interfaces there than perf/oprofile. I will continue to try to 
find some more information about that.

Best regards,
Dennis


[1] *F. Oboril*, J. Ewert, and M. B. Tahoori, "High-Resolution Online 
Power Monitoring for Modern Microprocessors," in Proceedings of Design, 
Automation & Test in Europe (*DATE*), 2015, France. Online available: 
*http://cdnc.itec.kit.edu/downloads/Papers/Oboril15DATE.pdf
*
