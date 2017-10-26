From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf buildid-cache -p <path> question
Date: Thu, 26 Oct 2017 09:07:21 +0200
Message-ID: <2b863f9e-e3f3-fa7f-7014-679d7fac63ea@linux.vnet.ibm.com>
References: <8594e11c-9aa1-f600-3f04-eb80058c9abf@linux.vnet.ibm.com>
 <20171022001703.c56a77784dbc49b258d36bf7@kernel.org>
 <7d8827b9-2517-dfdb-b5fb-64088c81c0c7@linux.vnet.ibm.com>
 <20171026015723.6d9202ce81b2fb222993f63b@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750997AbdJZHHZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Oct 2017 03:07:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9Q75VbL157679
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2017 03:07:25 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2du7q4gqm3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2017 03:07:24 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 26 Oct 2017 08:07:23 +0100
In-Reply-To: <20171026015723.6d9202ce81b2fb222993f63b@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On 10/25/2017 06:57 PM, Masami Hiramatsu wrote:

...

>>
>> When you look at the patch I submitted, in function build_id_cache__purge_path()
>> you specify a fully qualified path name, for example /usr/bin/tar. This is a file
>> and it calls function build_id_cache__remove_file() to remove its entries in the cache.
> 
> OK, now I see what the question is based on...
> I'll see your patch.
> 
> Thank you,
> 

I think we drop the patch and change the man page instead.
Any objections?

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
