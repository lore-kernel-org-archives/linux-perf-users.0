From: Alen Stojanov <astojanov@inf.ethz.ch>
Subject: Re: Some troubles with perf and measuring flops
Date: Thu, 6 Mar 2014 20:41:38 +0100
Message-ID: <5318CF72.20504@inf.ethz.ch>
References: <5317C76A.4050103@inf.ethz.ch> <alpine.DEB.2.10.1403052036580.22262@vincent-weaver-1.um.maine.edu> <5317D4FF.1030302@inf.ethz.ch> <alpine.DEB.2.10.1403061323200.22334@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from edge20.ethz.ch ([82.130.99.26]:15553 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbaCFTgh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Mar 2014 14:36:37 -0500
In-Reply-To: <alpine.DEB.2.10.1403061323200.22334@vincent-weaver-1.um.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org

On 06/03/14 19:25, Vince Weaver wrote:
> On Thu, 6 Mar 2014, Alen Stojanov wrote:
>
>>> more complicated with AVX in the mix.  What does the intel documentation
>>> say for the event for your architecture?
>> I agree on this. However, if you would look at the .s file, you can see that
>> it does not have any AVX instructions inside.
> I'm pretty sure vmovsd and vmuld are AVX instructions.

Yes you are absolutely right. I made a wrong statement. What I really 
meant was that there are no AVX instructions on packed doubles, since 
vmovsd and vmulsd operate with scalar doubles. This is also why I get 
zeros whenever I do:

  perf stat -e r530211 ./mmmtest 600

  Performance counter stats for './mmmtest 600':

                  0 r530211

        0.952037328 seconds time elapsed

What I really wanted to depict was the fact that I don't have to mix 
several counters to obtain results, as there would always be only 
FP_COMP_OPS_EXE:SSE_SCALAR_DOUBLE as an event in the code.

>> And if I would monitor any other
>> event on the CPU that counts any flop operations, I get 0s. It seems that the
>> FP_COMP_OPS_EXE:SSE_SCALAR_DOUBLE is the only one that occurs. I don't think
>> that FP_COMP_OPS_EXE:SSE_SCALAR_DOUBLE counts speculative events.
> are you sure?
>
> See http://icl.cs.utk.edu/projects/papi/wiki/PAPITopics:SandyFlops
> about FP events on SNB and IVB at least.

Thank you for the link. I only made the assumption that we do not have 
speculative events, since in a previous project that was done as part of 
my research group, we were able to get accurate flops, using Intel PCM: 
https://github.com/GeorgOfenbeck/perfplot/ (and we were able to get 
correct flops of a of a mmm having size 1600x1600x1600).

Nevertheless, as much as I understood, the PAPI is discussing count 
deviations whenever several counters are combined. In my use case that I 
send you before, I would always use one single raw counter to obtain 
counts. But the deviations that I obtain, they grow as the matrix size 
grows. I made a list to depict how much the flops would deviate

List format:
(mmm size) (anticipated_flops) (obtained_flops) (anticipated_flops / 
obtained_flops * 100.0)
10      2000      2061      97.040
20      16000      16692      95.854
30      54000      58097      92.948
40      128000      132457      96.635
50      250000      257482      97.094
60      432000      452624      95.443
70      686000      730299      93.934
80      1024000      1098453      93.222
90      1458000      1573331      92.670
100      2000000      2138014      93.545
110      2662000      2852239      93.330
120      3456000      3626028      95.311
130      4394000      4783638      91.855
140      5488000      5979236      91.784
150      6750000      7349358      91.845
160      8192000      11324521      72.339
170      9826000      11000354      89.324
180      11664000      13191288      88.422
190      13718000      16492253      83.178
200      16000000      20253599      78.998
210      18522000      23839202      77.696
220      21296000      27832906      76.514
230      24334000      32056213      75.910
240      27648000      40026709      69.074
250      31250000      41837527      74.694
260      35152000      47291908      74.330
270      39366000      53534225      73.534
280      43904000      60193718      72.938
290      48778000      67230702      72.553
300      54000000      74451165      72.531
310      59582000      82773965      71.982
320      65536000      129974914      50.422
330      71874000      99894238      71.950
340      78608000      108421806      72.502
350      85750000      118870753      72.137
360      93312000      129058036      72.302
370      101306000      141901053      71.392
380      109744000      152138340      72.134
390      118638000      170393279      69.626
400      128000000      225637046      56.728
410      137842000      208174503      66.215
420      148176000      205434911      72.128
430      159014000      231594232      68.661
440      170368000      235422186      72.367
450      182250000      280728129      64.920
460      194672000      282586911      68.889
470      207646000      310944304      66.779
480      221184000      409532779      54.009
490      235298000      381057200      61.749
500      250000000      413099959      60.518
510      265302000      393498007      67.421
520      281216000      675607105      41.624
530      297754000      988906780      30.109
540      314928000      1228529787      25.635
550      332750000      1396858866      23.821
560      351232000      2144144283      16.381
570      370386000      2712975462      13.652
580      390224000      3308411489      11.795
590      410758000      2326514544      17.656

And I cant see a pattern to derive any conclusion that makes sense.

>
> Vince
Alen
