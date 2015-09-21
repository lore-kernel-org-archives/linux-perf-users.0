From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: perf report and symbol addresses
Date: Mon, 21 Sep 2015 12:57:38 +0200
Message-ID: <1442833058.13087.414.camel@Rudolf-RHEL-7>
References: <1441212204.3349.256.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32841 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932321AbbIUK5l (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Sep 2015 06:57:41 -0400
In-Reply-To: <1441212204.3349.256.camel@transmode.se>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Wed, 2015-09-02 at 16:43 +0000, Joakim Tjernlund wrote:
> on PPC I do:
> # > perf record -a   /root/a.out
> 
> then 
> #> perf report -v
> ...
> 50.36%        a.out  /root/a.out                                               0x2c4      d [.] main
> 
> compare the address 0x2c4 with
> #> nm -a a.out  | grep main
>          U __libc_start_main@@GLIBC_2.0
> 100002c0 T main
> 
> The perf reported address is lacking 0x10000000.

What happens when you run perf record and perf report again? Is the
address reported by perf still the same?

What 'readelf -a' says about the binary?

> 
> How do I list the absolut symbol address?
> 
>  Jocke--
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
