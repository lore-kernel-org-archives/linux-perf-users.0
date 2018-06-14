From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/3] perf alias: Remove trailing newline when reading
 sysfs files
Date: Thu, 14 Jun 2018 11:05:29 -0300
Message-ID: <20180614140528.GE30043@kernel.org>
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180614114845.41221-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, jolsa@redhat.com, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Jun 14, 2018 at 01:48:43PM +0200, Thomas Richter escreveu:
> Remove a trailing newline when reading sysfs file contents
<SNIP>
> +	/* Remove trailing newline from sysfs file */
> +	cp = strrchr(buf, '\n');
> +	if (cp)
> +		*cp = '\0';
> +

We have rtrim()

- Arnaldo
