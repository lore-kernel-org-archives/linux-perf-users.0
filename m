From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 4/9] perf: test 15 add s390x support for stat test cases
Date: Wed, 9 Aug 2017 17:22:25 +0200
Message-ID: <20170809152225.GC23060@krava>
References: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
 <20170809064040.50899-4-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751523AbdHIPW1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 11:22:27 -0400
Content-Disposition: inline
In-Reply-To: <20170809064040.50899-4-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com

On Wed, Aug 09, 2017 at 08:40:35AM +0200, Thomas Richter wrote:
> The perf test 15 test cases test-stat-detailed[123]
> and test-stat-default fail for s390x.
> The reason is missing support of the CPUMF facility
> for some of the test.
> 
> The tests are now marked optional. On s390x some of the
> individual tests still fail, but when marked as optional,
> do not cause the complete test to fail.

hum I wonder we should switch the optional keyword with that
arch support you introduced recently.. this way we 'disable'
those tests for other archs

jirka
