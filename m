From: Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH 1/3] perf auxtrace: Support for perf report -D for s390
Date: Fri, 3 Aug 2018 12:07:58 +0200
Message-ID: <20180803100758.GA28475@linux.ibm.com>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-2-tmricht@linux.ibm.com>
 <20180802124909.GB7996@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180802124909.GB7996@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Arnaldo,

On Thu, Aug 02, 2018 at 09:49:09AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 02, 2018 at 09:46:20AM +0200, Thomas Richter escreveu:
> > Add initial support for s390 auxiliary traces using the
> > CPU-Measurement Sampling Facility.
> 
> Could you please provide one or two paragraphs explaining what is this
> "CPU-Measurement Sampling Facility", in which hardware this is available
> (all s/390 hardware has it? Just the 64-bit model(s)?) and provide a
> public URL for people interested in further reading?

The CPU-Measurement Facility (CPU-MF) provides a set of functions to obtain
performance information on the mainframe.  Basically, it was introduced
with System z10 years ago for the z/Architecture, that means, 64-bit.
For Linux, there are two facilities of interest, counter facility and sampling
facility.  The counter facility provides hardware counters for instructions,
cycles, crypto-activities, and many more.

The sampling facility is a hardware sampler that when started will write
samples at a particular interval into a sampling buffer.  At some point,
for example, if a sample block is full, it generates an interrupt to collect
samples (while the sampler continues to run).

Few years ago, I started to provide the a perf PMU to use the counter
and sampling facilities.  Recently, the device driver was updated to also
"export" the sampling buffer into the AUX area.  Thomas now completed the
related perf work to interpret and process these AUX data.

If people are more interested in the sampling facility, they can have a
look into:

- The Load-Program-Parameter and the CPU-Measurement Facilities, SA23-2260-05
  http://www-01.ibm.com/support/docview.wss?uid=isg26fcd1cc32246f4c8852574ce0044734a

and to learn how-to use it for Linux on Z, have look at chapter 54,
"Using the CPU-measurement facilities" in the:

- Device Drivers, Features, and Commands, SC33-8411-34
  http://public.dhe.ibm.com/software/dw/linux390/docu/l416dd34.pdf


Thanks and kind regards,
  Hendrik
