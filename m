From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Perf stat: add the date for each measurement
Date: Fri, 12 Jan 2018 13:48:13 -0300
Message-ID: <20180112164813.GF9655@kernel.org>
References: <416177EA-7E58-419F-8E1B-81118DEB8152@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934081AbeALQsR (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Jan 2018 11:48:17 -0500
Content-Disposition: inline
In-Reply-To: <416177EA-7E58-419F-8E1B-81118DEB8152@hpe.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Pourroy, Jean" <jean.pourroy@hpe.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Em Thu, Jan 11, 2018 at 03:09:15PM +0000, Pourroy, Jean escreveu:
> Hello everyone,
> 
> Do you know if there is a way to add the date on each line of the « perf stat » results (first column in the example above).
> Here an example of what I want to get:
> 
> 
> @../test > perf stat -a  -e uncore_imc_0/cas_count_read/  -I 1000 sleep 3
> 
> # <date +%s>		time counts	unit 		events
> 1515682946     	1.001277764 	1.72 MiB  uncore_imc_0/cas_count_read/
> 1515682947     	2.002748567 	1.90 MiB  uncore_imc_0/cas_count_read/
> 1515682948		3.003294258 	4.68 MiB  uncore_imc_0/cas_count_read/
> …

Not that I can remember, but a patch for that would be welcome :-)

- Arnaldo
