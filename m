From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf annotate: Handle s390 pc relative load and store
 instruction.
Date: Thu, 8 Mar 2018 09:52:20 -0300
Message-ID: <20180308125220.GZ3701@kernel.org>
References: <20180308120913.14802-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308120913.14802-1-tmricht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Mar 08, 2018 at 01:09:13PM +0100, Thomas Richter escreveu:
> S390 has several load and store instructions with target operand
> addressing relative to the program counter, for example lrl, lgrl,
> strl, stgrl.

Thanks, applied.

- Arnaldo
