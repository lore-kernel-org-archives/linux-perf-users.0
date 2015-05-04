From: Harald Servat <harald.servat@bsc.es>
Subject: Re: About using PEBS from the user space
Date: Mon, 04 May 2015 12:17:14 +0200
Message-ID: <5547472A.5010908@bsc.es>
References: <55469B90.1090903@bsc.es> <alpine.DEB.2.11.1505031816450.4940@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080204070003010304070105"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:54897 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbbEDKRS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 4 May 2015 06:17:18 -0400
In-Reply-To: <alpine.DEB.2.11.1505031816450.4940@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080204070003010304070105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 04/05/15 00:19, Vince Weaver wrote:
> On Mon, 4 May 2015, Harald Servat wrote:
>
>> Dear list,
>>
>>    I'd like to use the perf library to access PEBS so as to collect referenced
>> memory addresses from the user space. I think I've successfully setup the perf
>> structures (struct perf_event_attr) to configure the performance counters, but
>> I don't see what should I do to access to the captured memory addresses. I've
>> seen that within arch/x86/kernel/cpu/perf_event_intel_ds.c there are the
>> routines alloc_pebs_buffer, alloc_ds_buffer which seems to allocate and setup
>> the necessary buffers using kmalloc_node calls. Question is, how can replicate
>> this from the user space? And how we should connect these buffers to the PEBS
>> infrastructure using perf calls?
>
> You can try looking at the example code in my perf_event_tests code.
> 	https://github.com/deater/perf_event_tests
>
> The stuff you are looking for is probably covered in the
> 	test/record_sample/samples_data_src
> 	test/record_sample/sample_weight
> and especially the
> 	test/record_sample/sample_regs_intr
> tests, although that last one requires a fairly recent kernel to work.
>
> Vince

   Vince,

   that is really interesting work, thank you! However, for some reason 
the PEBS collected address is never shown (and maybe not captured) 
according to the following partial output

PERF_RECORD_SAMPLE [c001], MISC=16386 
(PERF_RECORD_MISC_USER,PERF_RECORD_MISC_EXACT_IP ), Size=32
	PERF_SAMPLE_IP, IP: 404510
	PERF_SAMPLE_WEIGHT, Weight: 30
	PERF_SAMPLE_DATA_SRC, Raw: 68100242
		Load Hit Line fill buffer No snoop Hit Level 1 TLB Level 2 TLB
PERF_RECORD_SAMPLE [c001], MISC=16386 
(PERF_RECORD_MISC_USER,PERF_RECORD_MISC_EXACT_IP ), Size=32
	PERF_SAMPLE_IP, IP: 404524
	PERF_SAMPLE_WEIGHT, Weight: 76
	PERF_SAMPLE_DATA_SRC, Raw: 68100442
		Load Hit L2 cache No snoop Hit Level 1 TLB Level 2 TLB
PERF_RECORD_SAMPLE [c001], MISC=16386 
(PERF_RECORD_MISC_USER,PERF_RECORD_MISC_EXACT_IP ), Size=32
	PERF_SAMPLE_IP, IP: 404524
	PERF_SAMPLE_WEIGHT, Weight: 77
	PERF_SAMPLE_DATA_SRC, Raw: 68100842
		Load Hit L3 cache No snoop Hit Level 1 TLB Level 2 TLB

   I've looked into your code in order to compare it with the perf tool 
and it looks like you support it in the code in the following lines of 
lib/parse_record.c, so it looks that sample_type is not tagged with 
PERF_SAMPLE_ADDR bit.

511             if (sample_type & PERF_SAMPLE_ADDR) {
512                 long long addr;
513                 memcpy(&addr,&data[offset],sizeof(long long));
514                 if (!quiet) printf("\tPERF_SAMPLE_ADDR, addr: 
%llx\n",addr);
515                 offset+=8;
516             }

   I tweaked a bit the perf dump application so that it prints the 
sample_type and it always shows c10f whereas your binary prints c001. If 
I simply go to one of the tests (say sample_data_src.c) and force 
pe.sample = 0xc10f then it works (printing additional data). So, would 
the following change make sense into your code to emit the sampled address?

Best regards.



WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

http://www.bsc.es/disclaimer
--------------080204070003010304070105
Content-Type: text/x-patch;
 name="sample_data_src.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sample_data_src.c.patch"

diff --git a/tests/record_sample/sample_data_src.c b/tests/record_sample/sample_data_src.c
index 1c3d260..35c7e81 100644
--- a/tests/record_sample/sample_data_src.c
+++ b/tests/record_sample/sample_data_src.c
@@ -113,7 +113,7 @@ int main(int argc, char **argv) {
         pe.size=sizeof(struct perf_event_attr);
         pe.sample_period=SAMPLE_FREQUENCY;
         pe.sample_type=PERF_SAMPLE_IP | PERF_SAMPLE_WEIGHT |
-			PERF_SAMPLE_DATA_SRC;
+			PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_ADDR ;
 
 	global_sample_type=pe.sample_type;
 

--------------080204070003010304070105--
