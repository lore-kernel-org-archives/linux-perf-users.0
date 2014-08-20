From: David Ahern <dsahern@gmail.com>
Subject: Re: perf cross compilation on yocto-linux for ARM fails
Date: Tue, 19 Aug 2014 19:54:36 -0600
Message-ID: <53F3FFDC.8090007@gmail.com>
References: <loom.20140812T234636-955@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:55720 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbaHTByq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 Aug 2014 21:54:46 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so10837763pde.39
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2014 18:54:46 -0700 (PDT)
In-Reply-To: <loom.20140812T234636-955@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Suresh Nagarajan <Sureshnagaraja@gmail.com>, linux-perf-users@vger.kernel.org

On 8/12/14, 3:49 PM, Suresh Nagarajan wrote:
>
> perf cross compilation on yocto-linux for ARM fails.  I've seen posts on
> this failure on internet but no where a detailed info is given on what was
> the fix (or if there is a fix yet)
>
> using yocto package, I have run into issues..
>
> Here are the steps to run into the issue
> $ cd ~
> $ git clone http://git.rocketboards.org/poky-socfpga.git
> $ cd  poky-socfpga/
> $ git checkout -b <test_branch> ACDS14.0_REL_GSRD_PR
> $ source ./altera-init build
> $ bitbake perf
>
> Note: replace <test_branch> with the name of the branch you want to use
> locally.

you should create a recipe to build perf within the yocto framework.

David
