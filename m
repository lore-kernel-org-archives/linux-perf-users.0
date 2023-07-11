Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3FEEB64DD
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Jul 2023 19:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGKTF1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Jul 2023 15:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGKTF0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Jul 2023 15:05:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1107E60
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 12:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689102321; x=1720638321;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=T0zlaESnLnZcnU7RFutA/jZfsbUeco24Cp68ut0m1jM=;
  b=n4VmCFwKbudGmZFCzymHnt2dsJM+zINyfJGH41lfsxSDRWZw7u/8kbK9
   Kbi8N4dQm/3xY631WnxSIr0P2YK1UHtxOX4pKpk4I+X1ZbMAg93w9PzAH
   Z36XkK9bkZ3QQfGeo7uTm15tI0cWZDzQ0HK2xeSYeH+JeOhqjK4q/1AkG
   9o62DiYOZK+fTtT2AwHQgKk3Fzog9umy9y0+tCUM3DnxhbESxjmnfSfGT
   HWAkMqWF7u/bfiuCAN9YFbwWJgCdJ/vDZVzh7jAmx04mXLEduZUXE0K5E
   RgTHgYXTuqlOqLVdPyf/VUSnxl5t+TBdKgPq6yv7g2rux22FrWwksQHNa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="395502258"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="395502258"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 12:05:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="715272654"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="715272654"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.50])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 12:05:18 -0700
Message-ID: <ac0f7815-e14d-f1e0-a44e-bc4a19f0b8c8@intel.com>
Date:   Tue, 11 Jul 2023 22:05:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: Using Intel PT with JIT
Content-Language: en-US
To:     Roman Lozko <lozko.roma@gmail.com>,
        linux-perf-users@vger.kernel.org
References: <CAEhC_Bkc9gV72k1iLqGjpjmRGx8aMjS6n_6gmmdr=XTzNeFc=g@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAEhC_Bkc9gV72k1iLqGjpjmRGx8aMjS6n_6gmmdr=XTzNeFc=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/07/23 16:54, Roman Lozko wrote:
> Hi, I tried to use `perf record` with Intel PT but afterwards I can't
> inject JIT dump to trace, `perf inject` says:
> 
> error, jitted code must be sampled with perf record -k 1
> 0x59d8 [0xb0]: failed to process type: 10 [Operation not permitted]
> 
> On the other hand, `-k 1` cannot be passed to `perf record`:
> 
> Cannot use clockid (-k option) with intel_pt
> 
> Is there a way to use Intel PT with jitted code? I am using perf
> 5.13.8, maybe it is already implemented in later versions?
> 

Seems to work:

$ cat HelloWorldApp.java  
import java.util.*;

/**
* The HelloWorldApp class implements an application that
* simply prints "Hello World!" to standard output.
*/
class HelloWorldApp {
       public static void main(String[] args) {
               System.out.println("Hello World!"); // Display the string.
       }
}
$ javac HelloWorldApp.java
$ perf version
perf version 5.13.8.g3cfdd7252e00
$ perf record  -e intel_pt//u -o java.perf.data java -agentpath:/home/ahunter/git/linux-stable/tools/perf/libperf-jvmti.so HelloWorldApp  
java: jvmti: jitdump in /home/ahunter/.debug/jit/java-jit-20230711.XXgKfxna/jit-75025.dump
Hello World!
[ perf record: Woken up 3 times to write data ]
[ perf record: Captured and wrote 4.072 MB java.perf.data ]
$ perf inject -i java.perf.data --jit -o java.perf.data.jitted                                                                              
$


