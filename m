From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCHv3] perf bpf: Fix endianness problem when loading
 parameters in prologue
Date: Wed, 16 Aug 2017 07:56:45 +0200
Message-ID: <01005d5f-e116-72db-f64b-1155ef032ccd@linux.vnet.ibm.com>
References: <20170815092159.31912-1-tmricht@linux.vnet.ibm.com>
 <20170815152540.GB22988@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751082AbdHPF4x (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Aug 2017 01:56:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7G5rvTi087789
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Aug 2017 01:56:53 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ccduuwtd3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Aug 2017 01:56:52 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 16 Aug 2017 06:56:50 +0100
In-Reply-To: <20170815152540.GB22988@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: wangnan0@huawei.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com

On 08/15/2017 05:25 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 15, 2017 at 11:21:59AM +0200, Thomas Richter escreveu:
> 
> Ok, I'm applying this, the only missing bit was the following line,
> right at the start of the patch message body;
> 
> From: Wang Nan <wangnan0@huawei.com>
> 
> To state that the patch was wrote by Wang, the fact that you
> participated in it with some adjustment is implied by having you sign
> off the patch, ok?
> 
> - Arnaldo


Thanks Arnaldo,

will /hopefully) remember next time.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
