Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF08C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Jun 2022 13:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiFONax (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiFONaw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Jun 2022 09:30:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F26432EC6
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 06:30:51 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FCXKUg020525
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 13:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=kJvoEWIHyLIRq25xeTMknPukP0uSN8x308bNPBtALN4=;
 b=gR/PP6oiCU3ZUcgeuMPPU4SBr4wVzgy1LSY8+vvR3iEkjNhp3GU0jgFyzf4JY+xfz4pn
 REiBkVStCWLQOFAhdEdictNBJKv41U79936J4gXw5SbYy0bPagkjTmlFFKgZo7A2vlQY
 mLKhvDRaQSMbwOq0jMBBZpEqDNc+/kl+ycIF7hwG0QwZ+TVPodNhcVB9//LmvhOFKijs
 cyO+fsY2LWUfmS9PBdpn4shP2LB9i9hCNGZF3AAy2Mzc3QHj/TNVlr8KZLBDmrWT4k1t
 VkTaJvzKtU5jLANt4xW/wKN1hhYhF2JsHl/UNRmXN67zCJEU1crM9Us++Dw1JDr237+X mA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gppw41vjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 13:30:50 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25FDKZTF025473
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 13:30:48 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3gmjp94jbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 13:30:48 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25FDUkXO23265636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 13:30:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D9B3A4053
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 13:30:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E41FBA4057
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 13:30:45 +0000 (GMT)
Received: from [9.145.158.89] (unknown [9.145.158.89])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 13:30:45 +0000 (GMT)
Message-ID: <b205da6a-d9a7-4c4b-521d-1b2515f6db4b@linux.ibm.com>
Date:   Wed, 15 Jun 2022 15:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     "linux-perf-use." <linux-perf-users@vger.kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: Strange behavior when event installed systemwide multiple times
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kbp7ZbtCB3YZwtTbyW9XPOqrvyja96Ra
X-Proofpoint-ORIG-GUID: kbp7ZbtCB3YZwtTbyW9XPOqrvyja96Ra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_13,2022-06-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0 mlxlogscore=955
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150052
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


I have a question regarding the behavior when 2 events are installed          
system-wide on the same CPU, for example:                                     
                                                                              
 # perf stat -e cpu-cycles -a -C0 -- sleep 5 &                                
 # sleep 2                                                                    
 # perf stat -e instructions -a -C0 -- true                                   
                                                                              
I wonder why at the 2nd perf invocation the event cpu-cycles is deleted       
from CPU 0 just to be re-added immediately. I understand this is necessary    
for events attached to a process. This is also done when the event is          
installed system wide, and is not connected to a process.                     
                                                                              
Looking at the trace                                                          
 # tracer: function                                                           
 #                                                                            
 #                    _-----=> irqs-off                                       
 #                   / _----=> need-resched                                   
 #                  | / _---=> hardirq/softirq                                
 #                  || / _--=> preempt-depth                                  
 #                  ||| /     delay                                           
 # TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION                               
 #    | |       |   ||||       |         |                                    
   perf-19574 [000] d... 10588.974577: x86_pmu_add <-event_sched_in.isra.130  
                                ---> 1st perf runs and 1st event installed    
   perf-19574 [000] d... 10588.974582: x86_pmu_start <-x86_pmu_enable         
   perf-19579 [000] d... 10590.974582: x86_pmu_del <-event_sched_out.isra.116 
   perf-19579 [000] d... 10590.974583: x86_pmu_stop <-x86_pmu_del             
                                ---> 2nd perf runs and 1st event is deleted   
   perf-19579 [000] d... 10590.974585: x86_pmu_add <-event_sched_in.isra.130  
                                ---> 1st event cpu-cycles re-added            
   perf-19579 [000] d... 10590.974586: x86_pmu_add <-event_sched_in.isra.130  
   perf-19579 [000] d... 10590.974586: x86_pmu_start <-x86_pmu_enable         
   perf-19579 [000] d... 10590.974587: x86_pmu_start <-x86_pmu_enable         
   perf-19579 [000] d... 10590.975361: x86_pmu_del <-event_sched_out.isra.116  
                                ---> 2nd perf stops and 2nd event removed     
   perf-19579 [000] d... 10590.975361: x86_pmu_stop <-x86_pmu_del             
   perf-19574 [000] d... 10593.975959: x86_pmu_del <-event_sched_out.isra.116 
   perf-19574 [000] d... 10593.975961: x86_pmu_stop <-x86_pmu_del                 
                                ---> 1st perf stops and 1st event removed.    
                                                                              
Is this intended behavior?

Thanks a lot.      
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
