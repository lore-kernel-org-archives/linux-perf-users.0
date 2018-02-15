From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/4] perf record: Provide detailed information on s390 CPU
Date: Thu, 15 Feb 2018 11:50:21 -0300
Message-ID: <20180215145021.GA30974@kernel.org>
References: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180213151419.80737-1-tmricht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Feb 13, 2018 at 04:14:16PM +0100, Thomas Richter escreveu:
> When perf record ... is setup to record data, the s390
> cpu information was a fixed string "IBM/S390".
> 
> Replace this string with one containing more information
> about the machine. The information included in the cpuid is
> a comma separated list:
>    manufacturer,type,model-capacity,model[,version,authorization]
> with

Thanks, applied 1-4

- Arnaldo
